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
        INVESTIGATOR_NAMES: list[str]

        def __init__(self):
            self.__model: ArkhamHorrorModel = None
            self.__view: ArkhamHorrorView = ArkhamHorrorView()
            ...

        def start(self):
            campaign: str = self.__view.prompt_campaign()
            investigators: list[str] = self.__view.prompt_investigators()
            difficulty: str = self.__view.prompt_difficulty()
            self.__model = ArkhamHorrorModel(campaign, investigators, difficulty)

        def __setup(self):
            ...
            lead_investigator: str = self.view.prompt_lead_investigator()
            for name,investigator in self.model.investigators.items():
                investigator.lead_investigator = name == lead_investigator
                investigator.gain_resources(5)
                investigator.draw_opening_hand()
                if self.view.prompt_mulligan():
                    investigator.mulligan()
            ...
    ```

    ```python
    class ArkhamHorrorModel:
        def __init__(
            self, controller: ArkhamHorror, campaign: str, difficulty: str, investigators: list[str]
         ):
            self.controller: ArkhamHorror = controller
            self.campaign: str = campaign
            self.difficulty: str = difficulty
            self.investigators: dict[str, Investigator] = dict()
            self.__create_investigators(investigators)
            self.chaos_bag: ChaosBag = None
            self.__assemble_chaos_bag()

        def __create_investigators(self, investigators: list[str]):
            for name in investigators:
                self.investigators[name] = Investigator(name)

        def __assemble_chaos_bag(self):
            self.chaos_bag = ChaosBag(token_data)
    ```

    ```python
    class Investigator:
        def __init__(self, name: str):
            self.__name: str = name
            self.player_deck: Deck = Deck(name, data)
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

            # Prompt for mulligan?

        def make_lead_investigator(self):
            self.is_lead_investigator = True
    ```

    ```python
    class Deck:
        def __init__(self, name: str, data: DataManager):
            self.__name: str = name
            self.__cards: deque[Card] = deque()
            self.__assemble_cards(data)
            self.shuffle()

        def __assemble_cards(self, data: DataManager):
            for card_name, quantity in data.deck_data[self.name].items():
                card: Card = Card(card_name, self.data.card_data[card_name])
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

        def __init__(self, name: str, card_data: dict):
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
    ```

    a. ...

1. Play
...

## Class Diagrams {#class-diagrams}

These are class diagrams...

## Sequence Diagrams {#sequence-diagrams}

These are sequence diagrams...
