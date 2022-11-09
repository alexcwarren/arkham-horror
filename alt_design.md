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
        __DATA_PATH: str = ...
        __TOKEN_FILE: str = ...
        __DECK_FILE: str = ...
        __CARD_FILE: str = ...

        def __init__(self):
            self.__model: ArkhamHorrorModel = None
            self.__view: ArkhamHorrorView = ArkhamHorrorView()
            self.__load_json_data()
            ...

        def __get_json_data(self, filename: str) -> dict:
            with open(f"{self.__DATA_PATH}{filename}", "r") as read_file:
                return json.load(read_file)

        def __load_json_data(self):
            self.token_data: dict = self.__get_json_data(TOKEN_FILE)
            self.deck_data: dict = self.__get_json_data(DECK_FILE)
            self.card_data: dict = self.__get_json_data(CARD_FILE)

        def start(self):
            campaign: str = self.__view.prompt_campaign()
            investigators: list[str] = self.__view.prompt_investigators()
            difficulty: str = self.__view.prompt_difficulty()
            self.__model = ArkhamHorrorModel(
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
        def __init__(
            self,
            controller: ArkhamHorror,
            campaign: str,
            difficulty: str,
            investigators: list[str]
         ):
            self.controller: ArkhamHorror = controller
            self.campaign: str = campaign
            self.difficulty: str = difficulty
            self.investigators: dict[str, Investigator] = dict()
            self.__create_investigators(investigators)
            self.chaos_bag: ChaosBag = None

        def __create_investigators(self, investigators: list[str]):
            for name in investigators:
                self.investigators[name] = Investigator(self.controller, name)

        def assemble_chaos_bag(self):
            self.chaos_bag = ChaosBag(self.controller, self.difficulty)

        def assemble_agenda_deck(self):
            ...

        def assemble_act_deck(self):
            ...

        def play_locations(self):
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
        def __init__(self, controller: ArkhamHorror, name: str):
            self.controller: ArkhamHorror = controller
            self.__name: str = name
            self.player_deck: Deck = Deck(self.controller, name)
            self.is_lead_investigator: bool = False
            self.__resource_pool: int = 0
            self.hand: list[Card] = list()

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
                if card.type == Card.WEAKNESS:
                    weakness_cards.append(card)
                    new_card: Card = None
                    while new_card is None or new_card.type == Card.WEAKNESS:
                        new_card = self.player_deck.draw_card()
                        if new_card.type == Card.WEAKNESS:
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
        def __init__(self, controller: ArkhamHorror, name: str):
            self.controller: ArkhamHorror = controller
            self.__name: str = name
            self.__cards: deque[Card] = deque()
            self.__assemble_cards()
            self.shuffle()

        def __assemble_cards(self):
            for name, quantity in self.controller.deck_data[self.name].items():
                card: Card = Card(self.controller, name)
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

        def draw_card(self) -> Card:
            return self.cards.pop()
    ```

    ```python
    class Card:
        WEAKNESS: str

        def __init__(self, controller: ArkhamHorror, name: str):
            self.controller: ArkhamHorror = controller
            self.__name: str = name
            self.__class: str = self.controller.card_data[name]["class"]
            self.__cost: str = self.controller.card_data[name]["cost"]
            self.__level: str = self.controller.card_data[name]["level"]
            self.__type: str = self.controller.card_data[name]["type"]
            self.__icons: str = self.controller.card_data[name]["icons"]
            self.__traits: str = self.controller.card_data[name]["traits"]
            self.__set: str = self.controller.card_data[name]["set"]
            self.__number: str = self.controller.card_data[name]["number"]
            self.__encounter: str = self.controller.card_data[name]["encounter"]
            self.__image_name_front: str = self.controller.card_data[name]["image_front"]
            self.__image_name_back: str = self.controller.card_data[name]["image_back"]

        @property
        def type(self) -> str:
            return self.__type
    ```

    ```python
    class ChaosBag:
        def __init__(self, controller: ArkhamHorror, difficulty: str):
            token_quantities: dict[str, int] = self.controller.token_data["difficulties"][difficulty]
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
        def __init__(self):
            ...

        def prompt_campaign(self):
            self.view.prompt_campaign()
            self.campaign = ...

        def prompt_investigators(self):
            ...
            # Between 1 and 4 (inclusive)
            num_investigators: int = ...
            ...
            for name in chosen_investigators:
                ...
                self.investigators[name] = Investigator(name, self.__data)

        def prompt_difficulty(self):
            ...
            difficulties: dict[str, str] = {
                "e": "Easy",
                "s": "Standard,
                "h": "Hard",
                "x": "Expert"
            }
            ...
            self.difficulty = difficulties[choice]

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
