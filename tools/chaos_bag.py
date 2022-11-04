import random
import json
import tkinter as tk
from tkinter import ttk


class ChaosBag(tk.Tk):
    def __init__(self, token_data):
        self.__token_values: dict[str, int] = token_data
        self.__tokens: list[str] = [key for key in self.__token_values]
        super().__init__()
        self.title("Chaos Bag")
        self.geometry("250x100")
        self.__build_result_window()
        self.__build_draw_token_button()

    def __build_result_window(self):
        __result_window_frame = ttk.Frame(self)
        __result_window_frame.pack(pady=15)
        self.__result_value = tk.StringVar()
        __result_window = tk.Entry(
            __result_window_frame,
            textvariable=self.__result_value,
            disabledbackground="white",
            disabledforeground="black",
            width=20,
            justify=tk.CENTER,
            state=tk.DISABLED,
        )
        __result_window.pack()

    def __build_draw_token_button(self):
        __draw_token_button_frame = ttk.Frame(self)
        __draw_token_button_frame.pack()
        __draw_token_button = ttk.Button(
            __draw_token_button_frame, text="Draw Token", command=self.__draw_token
        )
        __draw_token_button.pack()

    def __draw_token(self) -> str:
        rand_index: int = random.randint(0, len(self.__tokens) - 1)
        rand_token: str = self.__tokens[rand_index]
        self.__update_result_window(rand_token)

    def __update_result_window(self, token: str):
        self.__result_value.set(f'"{token}" = {self.__token_values[token]}')


def get_difficulty_input():
    entry = (
        input("Enter difficulty level ([E]asy / [s]tandard / [h]ard / e[x]pert: ")
        or "e"
    )
    return entry.lower()


if __name__ == "__main__":
    VALID_DIFFICULTIES = {"e": "Easy", "s": "Standard", "h": "Hard", "x": "Expert"}
    difficulty_input: str = get_difficulty_input()
    while difficulty_input not in VALID_DIFFICULTIES:
        print(f"{difficulty_input} not a valid entry.")
        difficulty_input: str = get_difficulty_input()
    difficulty = VALID_DIFFICULTIES[difficulty_input]

    chaos_tokens = dict()
    with open("../data/chaos-tokens.json", "r") as read_file:
        chaos_data = json.load(read_file)
        chaos_tokens = chaos_data["difficulties"][difficulty]

    chaos_bag = ChaosBag(chaos_tokens)
    chaos_bag.mainloop()
