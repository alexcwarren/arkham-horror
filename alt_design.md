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
    class DataManager:
        DATA_PATH: str
        
        def __init__(self):
            self.__token_data: dict = self.__get_json_data(...)
            self.__deck_data: dict = self.__get_json_data(...)
            self.__card_data: dict = self.__get_json_data(...)
            ...

        @property
        def token_data(self) -> dict:
            return self.__token_data

        @property
        def deck_data(self) -> dict:
            return self.__deck_data

        @property
        def card_data(self) -> dict:
            return self.__card_data

        def __get_json_data(self, filename: str) -> dict:
            with open(f"{self.DATA_PATH}{filename}", "r") as read_file:
                return json.load(read_file)
    ```

    ```python
    class ArkhamHorror:
        INVESTIGATOR_NAMES: list[str]

        def __init__(self):
            self.campaign: str = ""
            self.investigators: dict[str, Investigator] = dict()
            self.difficulty: str = ""
            self.chaos_bag: ChaosBag = None
            ...
            self.__data: DataManager = DataManager()

        @property
        def data(self) -> dict:
            return self.__data

        def start(self):
            self.prompt_campaign()
            self.prompt_investigators()
            self.prompt_difficulty()

        def prompt_campaign(self):
            ...
            self.campaign = ...

        def prompt_investigators(self):
            ...
            # Between 1 and 4 (inclusive)
            num_investigators: int = ...
            ...
            for name in chosen_investigators:
                ...
                self.investigators[name] = Investigator(
                    name, self.data
                )

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

        def setup(self):
            ...
            self.prompt_lead_investigator()
            self.assemble_chaos_bag()
            ...
            for investigator in self.investigators:
                investigator.gain_resources(5)
                investigator.draw_opening_hand()
            ...

        def prompt_lead_investigator(self):
            lead_investigator: str = ...
            self.investigators[lead_investigator].make_lead_investigator()

        def assemble_chaos_bag(self):
            self.chaos_bag = ChaosBag(self.data.token_data)
    ```

    ```python
    class Investigator:
        def __init__(self, name: str, data: dict):
            self.name: str = name
            self.player_deck: Deck = Deck(data)
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

            # Prompt for mulligan

        def make_lead_investigator(self):
            self.is_lead_investigator = True
    ```

    ```python
    class Deck:
        def __init__(self, data: dict):
            self.cards: deque[Card] = deque()
            self.assemble_cards()
            self.shuffle()

        def assemble_cards(self, data):
            for card_name, quantity in self.data.deck_data.items():
                card: Card = Card(card_name, card_data)
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

        def __init__(self, name: str, data: dict):
            self.__name: str = name
            ...
            self.__type: str

        @property
        def type(self) -> str:
            return self.__type
    ```

    ```python
    class ChaosBag:
        def __init__(self, token_quantities: dict[str, int]):
            self.tokens: list[str] = sorted(list(set(token_quantities)))

            self.token_probabilities: list[float] = list()
            self.calculate_token_probabilities(token_quantities)

        def calculate_token_probabilities(self, token_quantities: dict[str, int]):
            total_tokens: int = sum(count for count in quantities)
            self.token_probabilities.extend(
                token_quantities[token] / total_tokens for token in self.tokens
            )

        def draw_token(self):
            return random.choices(self.tokens, self.token_probabilities)[0]
    ```

    a. ...

1. Play
...

## Class Diagrams {#class-diagrams}

These are class diagrams...

## Sequence Diagrams {#sequence-diagrams}

These are sequence diagrams...
