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
        DATA_PATH: str
        TOKEN_FILE: str
        DECK_FILE: str
        FILES: list[str] = [...]

        def __init__(self):
            self.campaign: str = ""
            self.investigators: dict[str, Investigator] = dict()
            self.difficulty: str = ""
            self.chaos_bag: ChaosBag = None
            ...
            self.data: dict = dict()
            self.load_json_data()

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
            deck_data: dict = self.data[self.DECK_FILE]
            for name in chosen_investigators:
                ...
                self.investigators[name] = Investigator(
                    name, deck_data[name]
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
            token_data: dict = self.data[self.TOKEN_FILE]
            self.chaos_bag = ChaosBag(token_data)

        def load_json_data(self, filename: str) -> dict:
            for filename in self.FILES:
                with open(f"{self.DATA_PATH}{filename}", "r") as read_file:
                    self.data[filename] = json.load(read_file)
    ```

    ```python
    class Investigator:
        def __init__(self, name: str, player_deck_data: dict):
            self.name: str = name
            self.player_deck: Deck = Deck(player_deck_data)
            self.is_lead_investigator: bool = False
            self.hand: list[Card] = list()

        def draw_opening_hand(self):
            self.player_deck.draw_cards(5)

        def make_lead_investigator(self):
            self.is_lead_investigator = True
    ```

    ```python
    class Deck:
        def __init__(self, deck_data: dict):
            self.cards: deque[Card] = deque()
            self.assemble_cards()

        def assemble(self, deck_data):
            ...

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
