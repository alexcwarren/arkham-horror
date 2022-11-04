# Design

## Class Diagrams

### MVC

```mermaid
classDiagram
    ArkhamHorror *-- ArkhamHorrorModel
    ArkhamHorror *-- ArkhamHorrorView
    ArkhamHorror *-- ArkhamHorrorController
    class ArkhamHorror{
        -ArkhamHorrorModel model
        -ArkhamHorrorView view
        -ArkhamHorrorController controller
        +run()
    }
```

### Model {#ModelClassDiagram}

[Draw Card](#DrawCard)

```mermaid
classDiagram
    ArkhamHorrorModel -- Investigator
    ArkhamHorrorModel -- ChaosToken
    ArkhamHorrorModel -- EncounterDeck
    class ArkhamHorrorModel{
        -string CARD_IMAGES_PATH
        -List~Investigator~ investigators
        -List~ChaosToken~ chaos_bag
        +draw_token() ChaosToken
        -Card scenario_card
        -Deck agenda_deck
        -Deck act_deck
        -EncounterDeck encounter_deck
        -List~Card~ locations
        +set_up_game(string campaign_name, string part_name, List~string~ investigators, string difficulty)
        +get_scenario_card() string path
        +get_agenda_deck() List agenda_cards_tuple_of_frontpath_backpath
        +get_act_deck() List act_cards_tuple_of_frontpath_backpath
        +get_encounter_deck() List encounter_cards_tuple_of_frontpath_backpath
        +get_location_cards() List location_cards_tuple_of_frontpath_backpath
        +get_investigator_cards() List investigator_cards_tuple_of_frontpath_backpath
        +get_investigators_stats() Dict investigators_tuple_of_healthnum_sanitynum
        +get_investogators_decks() Dict list_of_investigators_decks_tuple_of_frontpath_backpath
        +draw_card(deck_name)
        +discard_drawn_card(deck_name)
        +play_card(deck_name, area_name)
        +get_area_state(area_name)
    }
    
    Card <|-- PlayerCard
    Card <|-- EncounterCard
    Card <|-- InvestigatorCard
    class Card{
        <<abstract>>
        +String type
        +Image front
        +Image back*
        +__init__(Dict~string, *~ json_card)*
    }
    
    PlayerCard <|-- AssetCard
    PlayerCard <|-- SkillCard
    PlayerCard <|-- EventCard
    PlayerCard <|-- WeaknessCard
    
    EncounterCard <|-- EnemyCard
    EncounterCard <|-- TreacheryCard
    
    Deck o-- Card
    Deck <|-- PlayerDeck
    Deck <|-- EncounterDeck
    class Deck{
        -Deque~Card~ cards
        -Deque~Card~ discard_pile
        -Card drawn_card
        -List~string~ playable_areas
        -__init__(Dict~string, int~ json_deck)
        +shuffle()
        +draw_card(): Card
        +discard()
        +play_card(area_name)
    }
    
    class ChaosToken{
        +String name
        +int value
    }

    Investigator -- PlayerDeck
    class Investigator{
        +string name
        +Card investigator_card
        +bool is_lead_investigator
        +PlayerDeck player_deck
        +int num_resources
        +List~Card~ assets
        +List~Card~ player_hand
    }
```

### View {#ViewClassDiagram}

[Draw Card](#DrawCard)


```mermaid
classDiagram
    ArkhamHorrorView <|-- ArkhamHorrorGUIView
    class ArkhamHorrorView{
        <<abstract>>
        +ArkhamHorrorController controller
        +string campaign_name
        +string part_name
        +List~string~ investigators
    }
    
    tkinter_Tk <|-- ArkhamHorrorGUIView

    ArkhamHorrorGUIView *-- MainMenuView
    ArkhamHorrorGUIView *-- TableTopView
    class ArkhamHorrorGUIView{
        -MainMenuView main_menu
        -TableTopView tabletop
        +run()
        -load_new_game_selection()
        -load_main_menu()
        -load_tabletop(string campaign, string part, List~string~ investigators, string scenariocard_path, List~string~ agendadeck_paths, List~string~ actdeck_paths, List~string~ encounterdeck_paths, List~string~ location_paths, List~string~ investigatorcard_paths, List~string~ playerdeck_paths)
    }

    tkinter_Frame <|-- GUISubView

    GUISubView <|-- MainMenuView
    GUISubView <|-- TableTopView
    GUISubView <|-- AreaView
    GUISubView <|-- CardView
    GUISubView <|-- CounterView
    GUISubView <|-- CardArrayView
    GUISubView <|-- DeckPanelView
    class GUISubView{
        <<abstract>>
        -ArkhamHorrorController controller
        +__int__(controller)
    }
    
    class MainMenuView{
        -Button new_game_button
        -Button load_game_button
        -build_menu_title()
        -build_menu_buttons()
    }

    TableTopView -- TitleAreaView
    TableTopView -- EncounterAreaView
    TableTopView -- LocationAreaView
    TableTopView -- ChaosBagAreaView
    TableTopView -- ThreatAreaView
    TableTopView -- PlayerAreaView
    class TableTopView{
        -TitleAreaView title_area
        -EncounterAreaView encounter_area
        -LocationAreaView location_area
        -ChaosBagAreaView chaos_bag_area
        -ThreatAreaView threat_area
        -PlayAreaView play_area
        -build_title_area()
        -build_encounter_area()
        -build_location_area()
        -build_threat_area()
        -build_play_area()
    }

    AreaView <|-- TitleAreaView
    AreaView <|-- EncounterAreaView
    AreaView <|-- LocationAreaView
    AreaView <|-- ChaosBagAreaView
    AreaView <|-- ThreatAreaView
    AreaView <|-- PlayAreaView
    class AreaView{
        <<abstract>>
        +string title
    }
    
    EncounterAreaView -- CardView
    EncounterAreaView -- CounterView
    EncounterAreaView -- DeckView
    EncounterAreaView -- DeckPanelView
    class EncounterAreaView{
        -ArkhamHorrorController controller
        -CardView scenario_card
        -DeckView agenda_deck
        -DeckView act_deck
        -CounterView doom_counter
        -encounter_deck = DeckPanelView(controller, name="encounter", playable_areas=["threat", "location"])
        +__init__(controller, ...)
    }
    
    class LocationAreaView{
        -List~List~LocationCardView~~ cards_grid
    }

    class ChaosBagAreaView{
        +draw_token()
    }

    ThreatAreaView -- CardArrayView
    class ThreatAreaView{
        -CardArrayView threat_cards
    }
    
    PlayAreaView -- CardArrayView
    PlayAreaView -- CardView
    PlayAreaView -- CounterView
    PlayAreaView -- DeckPanelView
    class PlayAreaView{
        -Combobox investigator_selection
        -CardArrayView assets
        -CardView investigator_card
        -CounterView resource_counter
        -CounterView health_counter
        -CounterView sanity_counter
        -player_deck = DeckPanelView(controller, name="player", playable_areas=["assets"])
    }
    
    CardView <|-- DeckView
    CardView <|-- LocationCardView
    CardView -- ImageLabel
    class CardView{
        -string view_title
        -string name
        -bool is_portrait_orientation=True
        -bool is_facedown=True
        -bool can_flip=False
        +__init__(controller, name, image)
        +flip()
        -load_zoom_view(image)
    }
    
    LocationCardView -- CounterView
    LocationCardView -- InvestigatorSlot
    class LocationCardView{
        -List~InvestigatorSlot~ investigator_slots
        -CounterView clue_counter
    }
    
    DeckView <|-- ScenarioDeckView
    class DeckView{
        -ArkhamHorrorController controller
        -bool can_shuffle=True
        -bool can_select=True
        +__init__(controller, string name, List~string~ playable_areas)
        +draw_card()
        +shuffle()
        +select()
        +discard()
        +play_card(area_name)
    }

    DeckPanelView -- DeckView
    class DeckPanelView{
        -string title
        -DeckView deck
        -DeckView discard_pile
        +__init__(controller, name, playable_areas)
    }
    
    CardArrayView *-- CardView
    class CardArrayView{
        -List~List~CardView~~ cards_grid
    }

    class CounterView{
        -string title
        -int start_value
        +__init__(controller, name)
        +increment()
        +decrement()
    }
```

### Controller {#ControllerClassDiagram}

[Draw Card](#DrawCard)

```mermaid
classDiagram
    ArkhamHorrorController *-- Setup
    class ArkhamHorrorController{
        -ArkhamHorrorModel model
        -ArkhamHorrorView view
        -Setup setup
        +run()
        +handle_new_game(string campaign_name, string part_name, List~string~ investigators, string difficulty)
        -get_setup() Setup
        +handle_flip(string name) string image_path
        +handle_shuffle_deck(string name)
        +handle_draw_card(string name) string image_path
        +handle_play_card(sring name)
        +handle_select_card(string name) string image_path
        +handle_update_counter(string name, int delta) string counter_num
    }

    class Setup{
        -string scenario_card_path
        -List~Tuple~ agenda_cards_paths
        -List~Tuple~ act_cards_paths
        -List~Tuple~ encounter_cards_paths
        -List~Tuple~ location_cards_paths
        -List~Tuple~ investigator_cards_paths
        -Dict~Tuple~ investigators_healthnum_sanitynum
        -Dict~Tuple~ nvestigators_decks_paths
    }

```

## Sequence Diagrams

### Run Game

```mermaid
sequenceDiagram
    %% Initialize (mostly to order lifelines: Model, Controller, View)
    ArkhamHorror ->>+ Model: __init__()
    Model -->>- ArkhamHorror: Model model

    %% Run
    ArkhamHorror ->>+ Controller: run()
        Controller ->>+ View: run()
            View ->>+ View: load_main_menu()
                View ->>+ Controller: get_game_selection_data()
                    Controller ->>+ Model: get_game_selection_data()
                    Model -->>- Controller: game_selection_data
                Controller -->>- View: game_selection_data
            View -->- View: 
        View -->- Controller: 
    Controller -->- ArkhamHorror: -
```

### New Game

```mermaid
sequenceDiagram
View ->> View: load_new_game_selection()
        View ->>+ Controller: play_new_game(...)
            Controller ->>+ Model: set_up_game(...)
            Model -->- Controller: 
            Controller ->>+ Controller: get_new_setup()
                %% Controller ->>+ Model: get_scenario_card()
                %% Model -->>- Controller: scenario_card
                %% Controller ->>+ Model: get_agenda_deck()
                %% Model -->>- Controller: agenda_deck
                %% Controller ->>+ Model: get_act_deck()
                %% Model -->>- Controller: act_deck
                %% Controller ->>+ Model: get_encounter_deck()
                %% Model -->>- Controller: encounter_deck
                %% Controller ->>+ Model: get_location_cards()
                %% Model -->>- Controller: location_cards
                %% Controller ->>+ Model: get_investigator_cards()
                %% Model -->>- Controller: investigator_cards
                %% Controller ->>+ Model: get_investigator_stats()
                %% Model -->>- Controller: investigator_stats
                %% Controller ->>+ Model: get_investigator_decks()
                %% Model -->>- Controller: investigator_decks
            Controller -->>- Controller: Setup new_setup
        Controller -->>- View: setup data
        View ->>+ View: load_tabletop()
```

### Draw Card from Deck {#DrawCard}

[View](#ViewClassDiagram)
[Controller](#ControllerClassDiagram)
[Model](#ModelClassDiagram)


```mermaid
sequenceDiagram
DeckView ->>+ DeckView: draw_card()
    DeckView ->>+ Controller: handle_draw_card(deck_name)
        Controller ->>+ Model: draw_card(deck_name)
            Model ->> Model: <deck_name>.draw_card()
        Model -->>- Controller: image_path
    Controller -->>- DeckView: image_path
    DeckView -->>+ DeckView: load_zoom_view(image_path)
```

#### Discard

```mermaid
sequenceDiagram
DeckView ->> DeckView: load_zoom_view(image_path)
    DeckView ->> DeckView: discard()
        DeckView ->> Controller: handle_discard(deck_name)
            Controller ->> Model: discard_drawn_card(deck_name)
                Model ->> Model: <deck_name>.discard()
```

#### Play

```mermaid
sequenceDiagram
%% Just to control order of lifelines
View --> DeckView: -

DeckView ->> DeckView: load_zoom_view(image_path)
    DeckView ->> DeckView: play_card(area_name)
        DeckView ->> Controller: handle_play_card(deck_name, area_name)
            Controller ->> Model: play_card(deck_name, area_name)
                Model -->> Model: <deck_name>.play_card(area_name)
        Controller ->>+ Model: get_area_state(area_name)
        Model -->>- Controller: area_data
        Controller ->> View: update(area_name, area_data)
```

<https://mermaid.live/>
<https://www.fluidui.com/editor/live/>
