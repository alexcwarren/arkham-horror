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
        DATA_PATH: str
        TOKEN_FILE: str

        def __init__(self):
            self.campaign: str
            self.investigators: list[Investigator]
            self.chaos_bag: ChaosBag
            ...

        def start(self):
            self.prompt_campaign()
            self.prompt_investigators()

        def prompt_campaign(self):
            ...

        def prompt_investigators(self):
            ...

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
            ...
        
        def assemble_chaos_bag(self):
            token_data: dict = self.get_chaos_token_data()
            self.chaos_bag = ChaosBag(token_data)

        def get_chaos_token_data(self) -> dict:
            return self.get_json_data(self.TOKEN_FILE)

        def get_json_data(self, filename: str) -> dict:
            with open(f"{self.DATA_PATH}{self.TOKEN_PATH}", "r") as read_file:
                return json.load(read_file)

    ```

    ```python
    class Investigator:
        def __init__(self):
            self.player_deck: Deck
            self.hand: list[Card]

        def draw_opening_hand(self):
            self.player_deck.draw_cards(5)
    ```

    ```python
    class Deck:
        def __init__(self):
            self.cards: list[Card]

        def draw_cards(self, num_cards):
            cards = list()
            for _ in range(num_cards):
                cards.append(self.draw_card())

        def draw_card(self):
            return self.cards.pop()
    ```

    ```python
    class Card:
        ...
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

    a. 

1. Play
...

## Class Diagrams {#class-diagrams}

These are class diagrams...

## Sequence Diagrams {#sequence-diagrams}

These are sequence diagrams...
