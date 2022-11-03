# Design

## High-Level Class Diagram

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

## Model Class Diagram

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
        -__init__(Dict~string, int~ json_deck)
        +shuffle()
        +draw_card(): Card
        -discard()
    }
    
    PlayerDeck o-- PlayerCard
    class PlayerDeck{
    }
    
    EncounterDeck o-- EncounterCard
    class EncounterDeck{
    }
    
    class ChaosToken{
        +String name
        +int value
    }

    Investigator -- InvestigatorCard
    Investigator -- PlayerDeck
    class Investigator{
        +string name
        +InvestigatorCard card
        +bool is_lead_investigator
        +PlayerDeck player_deck
        +int num_resources
        +List~Card~ player_hand
    }
```

## View Class Diagram

```mermaid
classDiagram
    ArkhamHorrorView <|-- ArkhamHorrorView_GUI
    class ArkhamHorrorView{
        <<abstract>>
        +ArkhamHorrorController controller
        +string campaign_name
        +string part_name
        +List~string~ investigators
    }
    
    ArkhamHorrorView_GUI *-- MainMenuView
    ArkhamHorrorView_GUI *-- TableTopView
    class ArkhamHorrorView_GUI{
        -MainMenuView main_menu
        -TableTopView tabletop
        +run()
        -load_new_game_selection()
        -load_main_menu()
        -load_tabletop(string campaign, string part, List~string~ investigators, string scenariocard_path, List~string~ agendadeck_paths, List~string~ actdeck_paths, List~string~ encounterdeck_paths, List~string~ location_paths, List~string~ investigatorcard_paths, List~string~ playerdeck_paths)
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
        -CardView scenario_card
        -DeckView agenda_deck
        -DeckView act_deck
        -CounterView doom_counter
        -DeckPanelView encounter_deck
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
        -DeckPanelView player_deck
    }
    
    CardView <|-- DeckView
    CardView <|-- LocationCardView
    class CardView{
        -string title
        -bool is_portrait_orientation=True
        -bool is_facedown=True
        -bool can_flip=False
        +flip()
    }
    
    LocationCardView -- CounterView
    class LocationCardView{
        -List investigator_slots
        -CounterView clue_counter
    }
    
    class DeckView{
        +__init__()
        -bool can_shuffle=True
        -bool can_select=True
        +draw()
        +shuffle()
        +select()
    }

    DeckPanelView -- DeckView
    class DeckPanelView{
        -string title
        -DeckView deck
        -DeckView discard_pile
    }
    
    CardArrayView *-- CardView
    class CardArrayView{
        -List~List~CardView~~ cards_grid
    }

    class CounterView{
        -string title
        -int start_value
        +increment()
        +decrement()
    }
```

## Controller Class Diagram

```mermaid
classDiagram
    ArkhamHorrorController *-- Setup
    class ArkhamHorrorController{
        -ArkhamHorrorModel model
        -ArkhamHorrorView view
        -Setup setup
        +run()
        +play_new_game(string campaign_name, string part_name, List~string~ investigators, string difficulty)
        -get_setup() Setup
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

## Run Sequence Diagram

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

## New Game Sequence Diagram

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

<https://mermaid.live/>
