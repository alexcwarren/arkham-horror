import json
import tkinter as tk
from tkinter import ttk


class ChaosBag(tk.Tk):
    def __init__(self, tokens):
        self.__tokens: list[str] = tokens
        super().__init__()
        super().title("Chaos Bag")
        super().geometry("500x500")


def get_difficulty_input():
    pass


if __name__ == "__main__":
    VALID_DIFFICULTIES = "eshx"
    difficulty: str = input(
        "Enter difficulty level ([E]asy / [s]tandard / [h]ard / e[x]pert: "
    ).lower()
    while difficulty not in VALID_DIFFICULTIES:
        print(f"{difficulty} not a valid entry.")
        difficulty: str = input(
            "Enter difficulty level ([E]asy / [s]tandard / [h]ard / e[x]pert: "
        )

    chaos_tokens = dict()
    with open("../data/chaos-tokens.json", "r") as read_file:
        chaos_data = json.load(read_file)
        chaos_tokens = chaos_data["difficulties"][difficulty]

    chaos_bag = ChaosBag(chaos_tokens)
    chaos_bag.mainloop()
