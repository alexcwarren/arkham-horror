import json
import tkinter as tk
from tkinter import ttk


class ChaosBag(tk.Tk):
    __datafile: string = ""

    def __init__(self, difficulty):
        super().__init__()
        super().title("Chaos Bag")
        super().geometry("500x500")
        self.__assemble(difficulty)

    def __assemble(self, difficulty):
        pass

    def __load_chaos_token_data(self):
        with open(ChaosBag.__datafile, "r") as read_file:
            pass


class Difficulty:
    __EASY = 0
    __STANDARD = 1
    __HARD = 2
    __EXPERT = 3

    @property
    def EASY(self):
        return self.__EASY

    @property
    def STANDARD(self):
        return self.__STANDARD

    @property
    def HARD(self):
        return self.__HARD

    @property
    def EXPERT(self):
        return self.__EXPERT


if __name__ == "__main__":
    chaos_bag = ChaosBag(Difficulty.EASY)
    chaos_bag.mainloop()
