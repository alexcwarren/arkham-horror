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
        def __init__(self):
            self.__model: ArkhamHorrorModel = None
            self.__view: ArkhamHorrorView = ArkhamHorrorView(self)

        def start(self):
            campaign: str = self.__view.prompt_campaign()
            investigators: list[str] = self.__view.prompt_investigators()
            difficulty: str = self.__view.prompt_difficulty()
            self.__model. = ArkhamHorrorModel(
                self, campaign, difficulty, investigators
            )

        def __setup(self):
            self.__model.assemble_chaos_bag()
            self.__set_up_investigators()
            self.__model.assemble_agenda_deck()
            self.__model.assemble_act_deck()
            self.__model.play_locations()
            self.__model.place_investigators()
            self.__model.assemble_aside_cards()
            self.__model.assemble_encounter_deck()
            self.__view.notify_begin_game()

        def __set_up_investigators(self):
            lead_investigator: str = self.__view.prompt_lead_investigator()
            for name,investigator in self.__model.investigators.items():
                investigator.lead_investigator = name == lead_investigator
                investigator.gain_resources(5)
                investigator.draw_opening_hand()
                if self.__view.prompt_mulligan():
                    investigator.mulligan()
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
            for location in self.__deck_data.get(
                f"{self.__part_name} - Locations"
            ):
                self.__locations[location] = Location(self, location)
            ...

        def place_investigators(self):
            ...

        def assemble_aside_cards(self):
            ...

        def assemble_encounter_deck(self):
            ...
    ```

    ```python
    class Investigator:
        def __init__(self, model: ArkhamHorrorModel, name: str):
            self.model: ArkhamHorrorModel = model
            self.__name: str = name
            self.__player_deck: Deck = Deck(self.model, name)
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
            self.hand = self.player_deck.draw_cards(5)

            weakness_cards: list[Card] = list()
            for i,card in enumerate(self.hand.copy()):
                if card.type == Card.TYPE.WEAKNESS:
                    weakness_cards.append(card)
                    new_card: Card = None
                    while new_card is None or new_card.type == Card.TYPE.WEAKNESS:
                        new_card = self.player_deck.draw_card()
                        if new_card.type == Card.TYPE.WEAKNESS:
                            weakness_cards.append(card)
                    self.hand[i] = new_card
            if weakness_cards:
                self.player_deck.shuffle_cards_back(weakness_cards)

        def mulligan(self, cards: list[Card]):
            for set_aside in cards:
                for i,card in enumerate(self.hand):
                    if card == set_aside:
                        self.hand[i] = self.player_deck.draw_card()
                        break
            self.player_deck.shuffle_cards_back(cards)

        def make_lead_investigator(self):
            self.is_lead_investigator = True
    ```

    ```python
    class Deck:
        def __init__(self, model: ArkhamHorrorModel, name: str):
            self.model: ArkhamHorrorModel = model
            self.__name: str = name
            self.__cards: deque[Card] = deque()
            self.__assemble_cards()

        def __assemble_cards(self):
            for name in self.model.get_deck_data(self.__name):
                card: Card = Card(self.model, name)
                for _ in range(quantity):
                    self.cards.append(card)

        def draw_card(self) -> Card:
            return self.cards.pop()
    ```

    ```python
    class RegularDeck(Deck):
        def __init__(self, model: ArkhamHorror, name: str):
            super().__init__(model, name)
            self.shuffle()

        def __assemble_cards(self):
            for name, quantity in self.model.get_deck_data(self.__name).items():
                card: Card = Card(self.model, name)
                for _ in range(quantity):
                    self.cards.append(card)

        def shuffle(self):
            random.shuffle(self.cards)

        def shuffle_card_back(self, card: Card):
            self.shuffle_cards_back([card])

        def shuffle_cards_back(self, cards: list[Card]):
            self.cards.extend(cards)
            self.shuffle()

        def draw_cards(self, num_cards) -> list[Card]:
            cards = list()
            for _ in range(num_cards):
                cards.append(self.draw_card())
            return cards
    ```

    ```python
    class Card:
        class TYPE:
            WEAKNESS: str = "weakness"

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

        @property
        def type(self) -> str:
            return self.__type
    ```

    ```python
    class Location:
        def __init__(self, model: ArkhamHorrorModel, name: str):
            self.model: ArkhamHorrorModel = model
            self.__name: str = name
            self.__is_revealed: bool
            self.__is_played_at_start: bool
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
    class ArkhamHorrorView:
        def __init__(self, controller: ArkhamHorror):
            self.controller: ArkhamHorror = controller
            ...

        def prompt_campaign(self) -> str:
            campaign = ...
            return campaign

        def prompt_investigators(self) -> list[str]:
            investigators = ...
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
            return difficulties[choice]

        def prompt_mulligan(self):
            ...

        def notify_begin_game(self):
            ...
    ```

    a. ...

1. Play
...

## Class Diagrams {#class-diagrams}

These are class diagrams...

## Sequence Diagrams {#sequence-diagrams}

These are sequence diagrams...
