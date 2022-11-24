# Alternate Design

## Table of Contents {#table-of-contents}

1. [Brainstorming](#brainstorming)
1. [Class Diagrams](#class-diagrams)
1. [Sequence Diagrams](#sequence-diagrams)

## Brainstorming {#brainstorming}

1. Start

    a. Choose `campaign`

    a. Choose `investigator(s)`

1. Setup

    a. Choose which `investigator` is **lead investigator**

    a. Assemble `player deck` for each `investigator`

    a. Assemble `chaos bag`

    a. Take **5** `resources` for each `investigator`

    a. Draw opening `hand` for each `investigator`

    ```python
    class ArkhamHorror:
        CLASS: str = "class"
        COST: str = "cost"
        LEVEL: str = "level"
        TYPE: str = "type"
        ICONS: str = "icons"
        TRAITS: str = "traits"
        SET: str = "set"
        NUMBER: str = "number"
        ENCOUNTER: str = "encounter"
        IMAGE_FRONT: str = "image_front"
        IMAGE_BACK: str = "image_back"

        class TYPES:
            INVESTIGATOR: str = "investigator"
            ASSET: str = "asset"
            TREACHERY: str = "treachery"
            EVENT: str = "event"
            SKILL: str = "skill"
            ENEMY: str = "enemy"
            SCENARIO: str = "scenario"
            AGENDA: str = "agenda"
            ACT: str = "act"
            LOCATION: str = "location"

        class __DECK_NAME:
            ACT: str = "act"
            AGENDA: str = "agenda"
            ENCOUNTER: str = "encounter"

        def __init__(self):
            self.__model: ArkhamHorrorModel = ArkhamHorrorModel(self)
            self.__view: ArkhamHorrorView = ArkhamHorrorView(self)

        def start(self):
            campaign: str = self.__view.prompt_campaign()
            investigators: list[str] = self.__view.prompt_investigators()
            difficulty: str = self.__view.prompt_difficulty()
            self.__model.set_info(campaign, difficulty, investigators)
            self.__decks: dict = {
                self.__DECK_NAME.ACT: self.__model.act_deck,
                self.__DECK_NAME.AGENDA: self.__model.agenda_deck,
                self.__DECK_NAME.ENCOUNTER: self.__model.encounter_deck
            }
            for name in investigators:
                self.__decks.setdefault(
                    name, self.__model.investigators[name].player_deck
                )

        def __setup(self):
            self.__model.assemble_chaos_bag()
            self.__model.set_up_investigators(
                self.__view.prompt_lead_investigator()
            )
            self.__model.assemble_agenda_deck()
            self.__model.assemble_act_deck()
            self.__model.play_locations()
            self.__model.assemble_aside_cards()
            self.__model.assemble_encounter_deck()
            self.__view.load_play_area()
            self.__view.notify_begin_game()

        def prompt_mulligan(self) -> list[str]:
            return self.__view.prompt_mulligan()

        def handle_draw_card(self, deck_name: str):
            deck = self.__decks[deck_name]
            drawn_card = deck.draw_card()
            self.__view.display_drawn_card(drawn_card.data, deck_name)

        def handle_discard(self, deck_name: str, card_name: str):
            deck = self.__decks[deck_name]
            deck.discard_card(card_name)
    ```

    ```python
    class ArkhamHorrorModel:
        __DATA_PATH: str = ...
        __CAMPAIGNS_FILE: str = ...
        __TOKENS_FILE: str = ...
        __CARDS_FILE: str = ...
        __DECKS_FILE: str = ...

        def __init__(
            self,
            controller: ArkhamHorror,
         ):
            self.controller: ArkhamHorror = controller
            self.__load_json_data()

        def set_info(
            self, campaign: str, difficulty: str, investigators: list[str]
        ):
            self.__campaign: str = campaign
            self.__difficulty: str = difficulty
            self.investigators: dict[str, Investigator] = dict()
            self.__part_name: str = self.__campaign_data[campaign][0]
            self.__create_investigators(investigators)
            self.__chaos_bag: ChaosBag = None
            self.__doom_counter: int = 0

        def set_up_investigators(self, lead_investigator: str):
            for name,investigator in self.investigators.items():
                investigator.is_lead_investigator = name == lead_investigator
                investigator.gain_resources(5)
                investigator.draw_opening_hand()
                returned_cards: list[str] = self.controller.prompt_mulligan()
                if returned_cards:
                    investigator.mulligan(returned_cards)

        def get_token_data(self, difficulty: str) -> dict:
            return self.__token_data.get(difficulty)

        def get_card_data(self, card_name: str) -> dict[str, str]:
            return self.__card_data.get(card_name)

        def get_deck_data(self, deck_name: str) -> dict[str, int]:
            return self.__deck_data.get(deck_name)

        def __get_json_data(self, filename: str) -> dict:
            with open(f"{self.__DATA_PATH}{filename}", "r") as read_file:
                return json.load(read_file)

        def __load_json_data(self):
            self.__campaign_data: list[str] = self.__get_json_data(__CAMPAIGNS_FILE)
            self.__token_data: dict = self.__get_json_data(__TOKENS_FILE)
            self.__card_data: dict = self.__get_json_data(__CARDS_FILE)
            self.__deck_data: dict = self.__get_json_data(__DECKS_FILE)

        def __create_investigators(self, investigators: list[str]):
            for name in investigators:
                self.investigators[name] = Investigator(self, name)

        def assemble_chaos_bag(self):
            self.__chaos_bag = ChaosBag(self, self.__difficulty)

        def assemble_agenda_deck(self):
            self.__agenda_deck: Deck = Deck(
                self, f"{self.__part_name} - Agenda"
            )

        def assemble_act_deck(self):
            self.__act_deck: Deck = Deck(
                self, f"{self.__part_name} - Act"
            )

        def play_locations(self):
            self.__locations: dict[str, Location] = dict()
            location_data: dict = self.__deck_data.get(
                f"{self.__part_name} - Locations"
            )
            for name, data in location_data.items():
                self.__locations[name] = Location(
                    self,
                    name,
                    data["is_played_at_start"],
                    data["shroud"],
                    data["clue_count"]
                )

        def assemble_aside_cards(self):
            self.__aside_cards: dict[Card] = {
                name: Card(self, name)
                for name in self.__deck_data.get(
                    f"{self.__part_name} - Aside"
                )
            }

        def assemble_encounter_deck(self):
            self.__encounter_deck: Deck = FullDeck(
                self, f"{self.__part_name} - Encounter"
            )

        def add_doom(self):
            self.__doom_counter += 1

        def reset_doom(self):
            self.__doom_counter = 0
    ```

    ```python
    class Investigator:
        def __init__(self, model: ArkhamHorrorModel, name: str):
            self.model: ArkhamHorrorModel = model
            self.__name: str = name
            self.player_deck: Deck = FullDeck(self.model, name)
            self.is_lead_investigator: bool = False
            self.__resource_pool: int = 0
            self.__hand: list[Card] = list()

        @property
        def resource_pool(self) -> int:
            return self.__resource_pool

        def gain_resources(self, num_resources: int):
            self.__resource_pool += num_resources
        
        def lose_resources(self, num_resources: int):
            self.__resource_pool = max(0, self.__resource_pool - num_resources)

        def draw_opening_hand(self):
            self.__hand = self.player_deck.draw_cards(5)

            weakness_cards: list[Card] = list()
            for i,card in enumerate(self.__hand.copy()):
                while card.type == self.controller.TYPES.TREACHERY:
                    weakness_cards.append(card)
                    card = self.player_deck.draw_card()
                self.__hand[i] = card
            if weakness_cards:
                self.player_deck.shuffle_cards_back(weakness_cards)

        def mulligan(self, cards: list[str]):
            for returned in cards:
                for i,card in enumerate(self.__hand):
                    if card.name == returned:
                        self.__hand[i] = self.player_deck.draw_card()
                        break
            self.player_deck.shuffle_cards_back(cards)

        def make_lead_investigator(self):
            self.is_lead_investigator = True
    ```

    ```python
    from functools import singledispatchmethod


    class Deck:
        def __init__(self, model: ArkhamHorrorModel, name: str):
            self.model: ArkhamHorrorModel = model
            self.__name: str = name
            self.__cards: dict[Card] = dict()
            self.__card_pile: deque[Card] = deque()
            self.__discard_pile: deque[Card] = deque()
            self.__assemble_cards(self.model.get_deck_data(self.__name))

        @singledispatchmethod
        def __assemble_cards(self, deck_data):
            raise NotImplementedError

        @__assemble_cards.register
        def __assemble_cards_with_list(self, deck_data: list):
            for name in deck_data:
                card: Card = Card(self.model, name)
                self.__cards.setdefault(name, card)
                self.__card_pile.append(card)

        @__assemble_cards.register
        def __assemble_cards_with_dict(self, deck_data: dict):
            for name, quantity in deck_data.items():
                card: Card = Card(self.model, name)
                self.__cards.setdefault(name, card)
                for _ in range(quantity):
                    self.__card_pile.append(card)

        def draw_card(self) -> Card:
            return self.__card_pile.pop()

        def discard_card(self, card_name: str):
            self.__discard_pile.append(self.__cards[card_name])
    ```

    ```python
    class FullDeck(Deck):
        def __init__(self, model: ArkhamHorror, name: str):
            super().__init__(model, name)
            self.shuffle()

        def shuffle(self):
            random.shuffle(self.__card_pile)

        def shuffle_card_back(self, card_name: str):
            self.shuffle_cards_back([card_name])

        def shuffle_cards_back(self, card_names: list[str]):
            self.__card_pile.extend([self.__cards[name] for name in card_names])
            self.shuffle()

        def draw_cards(self, num_cards) -> list[Card]:
            cards = list()
            for _ in range(num_cards):
                cards.append(self.draw_card())
            return cards
    ```

    ```python
    class Card:
        def __init__(self, model: ArkhamHorrorModel, name: str):
            self.model: ArkhamHorrorModel = model
            self.__name: str = name
            card_data: dict = self.model.get_card_data(name)
            self.__class: str = card_data["class"]
            self.__cost: str = card_data["cost"] or None
            self.__level: str = card_data["level"] or None
            self.__type: str = card_data["type"]
            self.__icons: dict[str, int] = card_data["icons"] or None
            self.__traits: list[str] = card_data["traits"]
            self.__set: str = card_data["set"]
            self.__number: int = card_data["number"]
            self.__encounter: str = card_data["encounter"] or None
            self.__image_name_front: str = card_data["image_front"]
            self.__image_name_back: str = card_data["image_back"]

            self.__data: dict = {
                "name": self.__name,
                "type": self.__type,
                "front": self.__image_name_front,
                "back": self.__image_name_back
            }

        @property
        def name(self) -> str:
            return self.__name

        @property
        def type(self) -> str:
            return self.__type
    ```

    ```python
    class Location(Card):
        def __init__(
            self,
            model: ArkhamHorrorModel,
            name: str,
            is_played_at_start: bool,
            shroud: int,
            clue_count: int
        ):
            self.model: ArkhamHorrorModel = model
            self.__name: str = name
            self.__is_played_at_start: bool = is_played_at_start
            self.__shroud: int = shroud
            self.__clue_count: int = clue_count
            self.is_revealed: bool = false
            self.shroud_modifier: int = 0
    ```

    ```python
    class ChaosBag:
        def __init__(self, model: ArkhamHorrorModel, difficulty: str):
            token_quantities: dict[str, int] = self.model.get_token_data(difficulty)
            self.__tokens: list[str] = sorted(list(set(token_quantities)))

            self.__token_probabilities: list[float] = list()
            self.__calculate_token_probabilities(token_quantities)

        def __calculate_token_probabilities(self, token_quantities: dict[str, int]):
            total_tokens: int = sum(count for count in token_quantities)
            self.__token_probabilities.extend(
                token_quantities[token] / total_tokens for token in self.tokens
            )

        def draw_token(self):
            return random.choices(self.__tokens, self.__token_probabilities)[0]
    ```

    ```python
    class ArkhamHorrorView(tk.Tk):
        def __init__(self, controller: ArkhamHorror):
            self.controller: ArkhamHorror = controller
            self.__load_play_area()

        def prompt_campaign(self) -> str:
            self.campaign = ...
            return campaign

        def prompt_investigators(self) -> list[str]:
            self.investigators = ...
            return investigators

        def prompt_difficulty(self) -> str:
            ...
            difficulties: dict[str, str] = {
                "e": "Easy",
                "s": "Standard,
                "h": "Hard",
                "x": "Expert"
            }
            ...
            choice: str = ...
            ...
            self.difficulty: str = difficulties[choice]
            return self.difficulty

        def prompt_mulligan(self):
            ...

        def notify_begin_game(self):
            ...

        def load_play_area(self):
            self.__place_scenario_card(row, col)
            self.__place_act_deck(row, col)
            self.__place_agenda_deck(row, col)
            self.__place_doom_counter(row, col)
            self.__place_encounter_deck(row, col)
            self.__place_locations(row, col)
            self.__place_chaos_bag(row, col)
            self.__place_threat_area(row, col)
            self.__place_investigator_play_areas(row, col)

        def __place_scenario_card(self, row: int, col: int):
            scenario_card_view = CardView(
                self,
                self.controller,
                self.controller.get_scenario_card()
            )
            scenario_card_view.grid(row, col)

        def __place_act_deck(self, row: int, col: int):
            act_deck_view = DeckView(
                self, self.controller, self.controller.get_act_deck()
            )
            act_deck_view.grid(row, col)

        def __place_agenda_deck(self, row: int, col: int):
            agenda_deck_view = DeckView(
                self, self.controller, self.controller.get_agenda_deck()
            )
            agenda_deck_view.grid(row, col)

        def __place_doom_counter(self, row: int, col: int):
            doom_counter = CounterView(
                self, self.controller, self.controller.get_doom_counter()
            )
            doom_counter.grid(row, col)

        def __place_encounter_deck(self, row: int, col: int):
            encounter_deck = FullDeckView(
                self,
                self.controller,
                self.controller.get_encounter_deck()
            )
            encounter_deck.grid(row, col)

        def __place_locations(self, row: int, col: int):
            # lay out frame of grid of tiles to play locations in
            locations_frame = tk.Frame(self)
            ...
            locations_frame.grid(row, col)

        def __place_chaos_bag(self, row: int, col: int):
            chaos_bag = ChaosBagView(
                self, self.controller, self.controller.get_chaos_bag()
            )
            chaos_bag.grid(row, col)

        def __place_threat_area(self, row: int, col: int):
            # lay out frame of grid of tiles to play enemies in
            threat_area_frame = tk.Frame(self)
            threat_area_frame.grid(row, col)
            ...

        def __place_investigator_play_areas(self, row, col):
            # lay out frame of tabs (one tab per investigator)
            investigators_frame = tk.Frame(self)
            investigators_frame.grid(row, col)

            for investigator in self.investigators:
                self.__place_investigator_play_area(
                    investigators_frame, investigator
                )

        def __place_investigator_play_area(
            self, master: tk.Frame, investigator: str
        ):
            self.__place_assets(master, investigator, row, col)
            self.__place_investigator_card(
                master, investigator, row, col
            )
            self.__place_player_counters(master, investigator, row, col)
            self.__place_player_deck(master, investigator, row, col)

        def __place_assets(
            self, master: tk.Frame, investigator: str, row: int, col: int
        ):
            assets_frame = tk.Frame(master)
            assets_frame.grid(row, col)

            NUM_ROWS: int = 2
            NUM_COLS: int = 4
            for r in range(NUM_ROWS):
                for c in range(NUM_COLS):
                    asset = AssetView(
                        assets_frame,
                        self.controller,
                        self.controller.get_empty_card()
                    )
                    asset.grid(r, c)

        def __place_investigator_card(
            self, master: tk.Frame, investigator: str, row: int, col: int
        ):
            investigator_card = FlipCardView(
                master,
                self.controller,
                self.controller.get_investigator_card(investigator)
            )
            investigator_card.grid(row, col)

        def __place_player_counters(
            self, master: tk.Frame, investigator: str, row: int, col: int
        ):
            counters_frame = tk.Frame(master)
            counters_frame.grid(row, col)
            resources_counter = CounterView(
                counters_frame,
                self.controller,
                self.controller.get_investigator_resources(investigator)
            )
            resources_counter.grid()
            health_counter = CounterView(
                counters_frame,
                self.controller,
                self.controller.get_investigator_health(investigator)
            )
            health_counter.grid()
            sanity_counter = CounterView(
                counters_frame,
                self.controller,
                self.controller.get_investigator_sanity(investigator)
            )
            sanity_counter.grid()

        def __place_player_deck(
            self, master: tk.Frame, investigator: str, row: int, col: int
        ):
            player_deck = FullDeckView(
                master,
                self.controller,
                self.controller.get_player_deck(investigator)
            )
            player_deck.grid(row, col)

        def display_drawn_card(self, card_data: dict, deck_name: str):
            # show pop-up window with drawn card
            drawn_card = DrawnCardWindow(
                self, self.controller, card_data, deck_name
            )
            drawn_card.show()
    ```

    ```python
    from functools import partial


    class DrawnCardWindow(tk...):
        def __init__(
                self, controller: ArkhamHorror, card_data: dict, deck_name: str
            ):
            super().__init__()
            card_view = CardView(self, controller, card_data)
            card_view.grid()
            if card_data[controller.TYPE] == controller.TYPES.ASSET:
                # add "Add to Assets" button
            if card_data[controller.TYPE] == controller.TYPES.ENEMY:
                # add "Add to Threat Area" button
            # add "Discard" button
            handle_discard = partial(
                self.controller.handle_discard,
                deck_name,
                card_data[self.controller.NAME]
            )
            discard_button = tk.Button(
                self,
                text="Discard",
                command=handle_discard
            )
            discard_button.grid()
    ```

    ```python
    class CounterView(tk.Frame):
        def __init__(
            self, master: tk.Frame, controller: ArkhamHorror, start_value: int
        ):
            super().__init__(master)
            self.controller: ArkhamHorror = controller
            self.__START_VALUE: int = start_value

            minus_button = tk.Button(
                self,
                command=self.__decrement
            )
            minus_button.grid()

            self.__value = tk.StringVar()
            value_window = tk.Entry(self, textvariable=self.__value)
            value_window.grid()

            plus_button = tk.Button(
                self,
                command=self.__increment
            )

            reset_button = tk.Button(
                self,
                command=self.__reset
            )

        def __modify_value(self, modifier: int):
            value = int(self.__value.get())
            self.__value.set(value + modifier)

        def __decrement(self):
            self.__modify_value(self, -1)

        def __increment(self):
            self.__modify_value(self, 1)

        def __reset(self):
            self.__value.set(self.__START_VALUE)
    ```

    ```python
    class ChaosBagView(tk.Frame):
        def __init__(self, master: tk.Frame, controller: ArkhamHorror, data):
            super().__init__(master)
            self.controller = controller

            draw_token_button = tk.Button(
                self,
                text="Draw Token",
                command=self.__draw_token
            )
            draw_token_button.grid()

            self.__token_result = tk.StringVar()
            token_result_window = tk.Entry(
                self,
                textvariable=self.__token_result
            )
            token_result_window.grid()

        def __draw_token(self):
            drawn_token = self.controller.draw_token()
            self.__token_result.set(drawn_token)
    ```

    ```python
    from PIL import Image, ImageTk


    class CardView:
        def __init__(
            self, master: tk.Frame, controller: ArkhamHorror, data
        ):
            super().__init__(master)
            self.controller = controller
            front_path = data["front"]
            front_image = ImageTk.PhotoImage(Image.open(front_path))
            self.__card = tk.Label(self, image=front_image)
            self.__images: list = [front_image]
    ```

    ```python
    class FlipCardView(CardView):
        def __init__(
            self, master: tk.Frame, controller: ArkhamHorror, data
        ):
            super().__init__(master, controller)
            back_path = data["back"]
            back_image = ImageTk.PhotoImage(Image.open(back_path))
            self.__images.append(back_image)
            self.__flip_index: int = 0

        def flip_card(self):
            self.__flip_index = (self.__flip_index + 1) % 2
            self.__card.configure(image=self.__images[self.__flip_index])
    ```

    ```python
    class AssetView(CardView):
        def __init__(self, master: tk.Frame, controller: ArkhamHorror):
            super().__init__(master, controller)
    ```

    ```python
    class DeckView(tk.Frame):
        def __init__(self, master: tk.Frame, controller: ArkhamHorror, data):
            super().__init__(master)
            self.__name: str = data["name"]
            card = FlipCardView(master, controller, data)
            card.grid()
            # add draw_card() to left click menu of commands
            self.left_click_menu.append(self.__draw_card)

        def __draw_card(self):
            next_card = self.controller.handle_draw_card(self.__name)
    ```

    a. ...

1. Play
...

## Class Diagrams {#class-diagrams}

These are class diagrams...

## Sequence Diagrams {#sequence-diagrams}

These are sequence diagrams...
