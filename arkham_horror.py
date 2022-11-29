import json
import tkinter as tk

import components.custom_widgets as custom_widgets


def __get_deck(key: str):
    with open("./data/decks.json", "r") as read_file:
        deck: dict = json.load(read_file).get(key)
        return deck


def get_playerdeck(playername: str):
    return __get_deck(playername)


def get_agendadeck(campaign: str, partname: str):
    pass


if __name__ == "__main__":
    playerdeck = get_playerdeck("Roland Banks")
    print(playerdeck)

    main = tk.Tk()
    main.geometry("250x50")
    entry = custom_widgets.DisabledEntry(main)
    entry.pack()
    main.mainloop()
