import json
import tkinter as tk
from tkinter import ttk


class DeckBuilder_GUI(tk.Tk):
    decks_file = "../data/decks.json"
    cards_file = "../data/cards.json"

    def __init__(self):
        super().__init__()
        self.decks_data = dict()
        self.excluded_deck_keys = []
        self.cards_data = dict()
        self.excluded_card_keys = ["skill-icons", "classes", "types", "traits", "sets"]
        self.load()
        self.title("Arkham Horror - Deck Builder")
        self.geometry("500x700")
        self.build_deck_selection_frame()
        self.build_card_list_frame()
        self.build_save_button_frame()

    def load(self):
        with open(self.decks_file, "r") as read_file:
            self.decks_data = json.load(read_file)
        with open(self.cards_file, "r") as read_file:
            self.cards_data = json.load(read_file)

    def save(self):
        deck = dict()
        for key, var in self.cards_vars.items():
            if var["is_checked"].get() == str(tk.TRUE):
                deck[key] = int(var["quantity"].get())
        self.decks_data[self.deck_selection_var.get()] = deck
        with open(self.decks_file, "w") as write_file:
            json.dump(self.decks_data, write_file)

    def load_deck(self):
        deck: dict = self.decks_data.get(self.deck_selection_var.get())
        if deck:
            self.clear()
            for card in deck:
                self.cards_vars[card]["is_checked"].set(tk.TRUE)
                self.cards_vars[card]["quantity"].set(str(deck[card]))

    def clear(self):
        for key in self.cards_vars:
            self.cards_vars[key]["is_checked"].set(tk.FALSE)
            self.cards_vars[key]["quantity"].set("1")

    def build_deck_selection_frame(self):
        self.deck_selection_frame = ttk.Frame(self)
        self.deck_selection_frame.pack(fill=tk.X)
        self.deck_selection_var = tk.StringVar()
        self.deck_selection = ttk.Combobox(
            self.deck_selection_frame, textvariable=self.deck_selection_var, width=40
        )
        self.deck_selection.pack()
        self.deck_selection["values"] = [
            key for key in self.decks_data if key not in self.excluded_deck_keys
        ]
        button_frame = ttk.Frame(self.deck_selection_frame)
        button_frame.pack(side=tk.TOP)
        self.load_deck_button = ttk.Button(
            button_frame, text="Load Deck", command=self.load_deck
        )
        self.load_deck_button.pack(side=tk.LEFT)
        self.clear_button = ttk.Button(
            button_frame, text="Clear", command=self.clear
        )
        self.clear_button.pack(side=tk.LEFT)

    def build_card_list_frame(self):
        self.card_list_frame = ttk.Frame(self)
        self.card_list_frame.pack(fill=tk.BOTH, expand=tk.TRUE)
        self.card_list_scrollbar = ttk.Scrollbar(
            self.card_list_frame, orient=tk.VERTICAL
        )
        self.card_list_scrollbar.pack(fill=tk.Y, side=tk.RIGHT, expand=tk.FALSE)
        self.card_list_canvas = tk.Canvas(
            self.card_list_frame, yscrollcommand=self.card_list_scrollbar.set
        )
        self.card_list_canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=tk.TRUE)
        self.card_list_scrollbar.config(command=self.card_list_canvas.yview)
        self.card_list_inner_frame = ttk.Frame(self.card_list_canvas)
        self.card_list_inner_frame_id = self.card_list_canvas.create_window(
            0, 0, window=self.card_list_inner_frame, anchor=tk.NW
        )
        self.card_list_inner_frame.bind(
            "<Configure>", self.__configure_card_list_inner_frame
        )
        self.card_list_canvas.bind("Configure", self.__configure_card_list_canvas)
        self.cards_vars = dict()
        for key in self.cards_data:
            if key not in self.excluded_card_keys:
                card_vars: dict = {"is_checked": None, "quantity": None}
                row_frame = ttk.Frame(self.card_list_inner_frame)
                row_frame.pack(fill=tk.X, expand=tk.TRUE)
                check_var = tk.StringVar()
                checkbutton = ttk.Checkbutton(
                    row_frame,
                    text=key,
                    variable=check_var,
                    onvalue=tk.TRUE,
                    offvalue=tk.FALSE,
                )
                card_vars["is_checked"] = check_var
                checkbutton.pack(side=tk.LEFT)
                card_vars["quantity"] = tk.StringVar()
                quantity_entry = ttk.Entry(
                    row_frame, textvariable=card_vars["quantity"], width=2
                )
                quantity_entry.insert(0, "1")
                quantity_entry.pack(side=tk.RIGHT)
                self.cards_vars[key] = card_vars

    def __configure_card_list_inner_frame(self, event):
        size = (
            self.card_list_inner_frame.winfo_reqwidth(),
            self.card_list_inner_frame.winfo_reqheight(),
        )
        self.card_list_canvas.config(scrollregion="0 0 %s %s" % size)
        if (
            self.card_list_inner_frame.winfo_reqwidth()
            != self.card_list_canvas.winfo_width()
        ):
            self.card_list_canvas.config(
                width=self.card_list_inner_frame.winfo_reqwidth()
            )

    def __configure_card_list_canvas(self, event):
        if (
            self.card_list_inner_frame.winfo_reqwidth()
            != self.card_list_canvas.winfo_width()
        ):
            self.card_list_canvas.itemconfigure(
                self.card_list_inner_frame_id, width=self.card_list_canvas.winfo_width()
            )

    def build_save_button_frame(self):
        self.save_button_frame = ttk.Frame(self)
        self.save_button_frame.pack()
        self.save_button = ttk.Button(
            self.save_button_frame, text="Save", command=self.save
        )
        self.save_button.pack()


if __name__ == "__main__":
    DeckBuilder_GUI().mainloop()
