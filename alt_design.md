# Alternate Design

## Table of Contents {#table-of-contents}

1. [Brainstorming](#brainstorming)
1. [Class Diagrams](#class-diagrams)
1. [Sequence Diagrams](#sequence-diagrams)

## Brainstorming {#brainstorming}

1. Begin

    a. Choose `campaign`

    a. Choose `investigator(s)`

    ```python
    List<Investigator> investigators
    ```

1. Setup

    a. Choose which `investigator` is **lead investigator**

    a. Assemble `player deck` for each `investigator`

    a. Assemble `chaos bag`

    a. Take **5** `resources` for each `investigator`

    a. Draw opening `hand` for each `investigator`

    ```python
    class ArkhamHorror:
        ...
        List<Investigator> investigators
        ChaosBag chaos_bag
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
            ...
    ```

    ```python
    class Investigator:
        ...
        Deck player_deck
        List<Card> hand
        ...
        def draw_opening_hand(self):
            self.player_deck.draw_cards(5)
    ```

    ```python
    class Deck:
        ...
        List<Card> cards
        ...
        def draw_cards(self, num_cards):
            cards = list()
            for _ in range(num_cards):
                cards.append(self.draw_card())
        ...
        def draw_card(self):
            return self.cards.pop()
    ```

    ```python
    class Card:
        ...
    ```

    ```python
    class ChaosBag:
        ...
    ```

    a. 

1. Play
...

## Class Diagrams {#class-diagrams}

These are class diagrams...

## Sequence Diagrams {#sequence-diagrams}

These are sequence diagrams...
