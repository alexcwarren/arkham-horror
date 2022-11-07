import json
import random
import tkinter as tk
from functools import partial
from tkinter import ttk


class ChaosBag(tk.Tk):
    def __init__(
        self, token_quantities: dict[str, int], special_values: dict[str, str]
    ):
        self.__unique_tokens: list[str] = sorted(
            set(list(token_quantities.keys()) + list(special_token_values.keys()))
        )
        self.__max_token_width: int = max(len(token) for token in self.__unique_tokens)

        self.__token_percentages: dict[str, float] = dict()
        total: int = sum(count for count in token_quantities.values())
        for token in self.__unique_tokens:
            self.__token_percentages[token] = token_quantities[token] / total * 100

        self.__token_values: dict[str, str] = dict()
        for token in self.__unique_tokens:
            if token in special_values:
                self.__token_values[token] = special_values[token]
            else:
                self.__token_values[token] = token

        self.__token_counts: dict[str, int] = dict.fromkeys(self.__unique_tokens, 0)
        self.__total_count: int = 0

        super().__init__()
        self.title("Chaos Bag")
        WIDTH: int = 250
        HEIGHT: int = 175
        self.geometry(f"{WIDTH}x{HEIGHT}")
        self.__build_result_window()
        self.__build_draw_token_button()
        self.__build_x_value_frame()

    def __build_result_window(self):
        __result_window_frame = ttk.Frame(self)
        __result_window_frame.pack(pady=15)
        self.__result_value = tk.StringVar()
        __result_window = tk.Entry(
            __result_window_frame,
            textvariable=self.__result_value,
            disabledbackground="white",
            disabledforeground="black",
            width=25,
            justify=tk.CENTER,
            state=tk.DISABLED,
        )
        __result_window.pack()

    def __build_draw_token_button(self):
        __draw_token_button_frame = ttk.Frame(self)
        __draw_token_button_frame.pack()
        __draw_token_button = ttk.Button(
            __draw_token_button_frame,
            text="Draw Token",
            command=self.__update_result_window,
        )
        __draw_token_button.pack()

    def __build_x_value_frame(self):
        __x_value_frame = ttk.Frame(self)
        __x_value_frame.pack(pady=15)

        __x_value_inc_button = ttk.Button(
            __x_value_frame,
            text="+",
            command=partial(self.__update_x_value, value=1),
        )
        __x_value_inc_button.pack()

        self.__x_value = tk.StringVar()
        self.__x_value.set("0")
        __x_value_entry = tk.Entry(
            __x_value_frame,
            textvariable=self.__x_value,
            width=5,
            justify=tk.CENTER,
        )
        __x_value_entry.pack()

        __x_value_dec_button = ttk.Button(
            __x_value_frame,
            text="-",
            command=partial(self.__update_x_value, value=-1),
        )
        __x_value_dec_button.pack()

    def __draw_token(self) -> str:
        drawn_token = random.choices(
            self.__unique_tokens, weights=list(self.__token_percentages.values())
        )[0]
        self.__token_counts[drawn_token] += 1
        self.__total_count += 1
        return drawn_token

    def __update_result_window(self):
        token = self.__draw_token()
        value = self.__token_values[token].replace("X", self.__x_value.get())
        self.__result_value.set(f'"{token}" = {value}')

    def __update_x_value(self, value):
        x: int = int(self.__x_value.get())
        updated_value: int = x + value if x + value >= 0 else 0
        self.__x_value.set(updated_value)

    def print_odds(self):
        print("EXPECTED")
        for token in self.__unique_tokens:
            perc = self.__token_percentages[token]
            print(f"{token :{self.__max_token_width}s}: {perc :.2f}%")
        print()
        print("ACTUAL")
        for token in self.__unique_tokens:
            perc = self.__token_counts[token] / self.__total_count * 100
            print(f"{token :{self.__max_token_width}s}: {perc :.2f}%")

    def simulate_odds(self, num_samples: int):
        unique_tokens: list[str] = list(set(self.__unique_tokens))
        samples: dict[str, int] = dict.fromkeys(unique_tokens, 0)
        for _ in range(num_samples):
            samples[self.__draw_token()] += 1

        max_units: int = 70
        max_count_width: int = max(len(str(count)) for count in samples.values())
        unit: int = max(count for count in samples.values()) // max_units
        for token in self.__unique_tokens:
            count = samples[token]
            print(f"{token :{self.__max_token_width}s}:", end="")
            print(f"{count :{max_count_width}d}", end="")
            print(f"({count/num_samples*100 :5.2f}%)", end="")
            print("*" * (count // unit))


def get_input(prompt: str, default: str):
    entry = input(prompt) or default
    return entry.lower()


def get_campaign(valid_campaigns: dict):
    campaign_input = get_input("Enter campaign ([N]ight of the zealot): ", "n")
    return valid_campaigns[campaign_input]


def get_part(valid_parts: dict):
    parts_input = get_input(
        "Enter part (the [G]athering / the [m]idnight masks / the [d]evourer below): ",
        "g",
    )
    return valid_parts[parts_input]


def get_difficulty(valid_difficulties: dict):
    difficulty_input = get_input(
        "Enter difficulty level ([E]asy / [s]tandard / [h]ard / e[x]pert): ", "e"
    )
    return valid_difficulties[difficulty_input]


if __name__ == "__main__":
    title: str = "Arkham Horror - Night of the Zealot"
    print("\n", "=" * len(title))
    print(title)
    print("=" * len(title), "\n")

    part = get_part(
        {"g": "The Gathering", "m": "The Midnight Masks", "d": "The Devourer Below"}
    )
    print(part, "\n")
    difficulty = get_difficulty(
        {"e": "Easy", "s": "Standard", "h": "Hard", "x": "Expert"}
    )
    print(difficulty, "\n")

    chaos_token_quantities = dict()
    special_token_values = dict()
    with open("../data/chaos-tokens.json", "r") as read_file:
        chaos_data = json.load(read_file)
        chaos_token_quantities = chaos_data["difficulties"][difficulty]
        special_token_values = chaos_data["scenarios"][part]

    chaos_bag = ChaosBag(chaos_token_quantities, special_token_values)

    # print("Odds:")
    # chaos_bag.print_odds()
    # print()

    # print("Simulation:")
    # chaos_bag.simulate_odds(30_000)
    # print()

    chaos_bag.mainloop()

    chaos_bag.print_odds()
    print()
