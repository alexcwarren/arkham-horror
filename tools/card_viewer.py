import json
import tkinter as tk
from tkinter import ttk

from PIL import Image, ImageTk


class CardViewer_GUI(tk.Tk):
    cards_file = "../data/cards.json"
    excluded_card_keys = ["skill-icons", "classes", "types", "traits", "sets"]
    images_path = "../data/card-images/"
    card_attributes = [
        "class",
        "cost",
        "level",
        "type",
        "icons",
        "traits",
        "set",
        "number",
        "encounter",
    ]

    def __init__(self):
        super().__init__()
        self.cards_data: dict = dict()
        self.cards: dict = dict()
        self.load()
        self.title("Arkham Horror - Card Viewer")
        self.geometry("1000x700")
        self.build_card_selection_frame()
        self.build_card_view_frame()

    def get_image_path(self, filename: str):
        return f"{self.images_path}{filename}"

    def get_image(self, filename: str = "empty.png"):
        image_file = Image.open(self.get_image_path(filename))
        return ImageTk.PhotoImage(image_file)

    def load(self):
        with open(self.cards_file, "r") as read_file:
            self.cards_data = json.load(read_file)
        self.cards = {
            key: value
            for key, value in self.cards_data.items()
            if key not in self.excluded_card_keys
        }
        self.card_selection_width = max([len(card_name) for card_name in self.cards])

    def load_card(self, event):
        self.selected_card: dict = self.cards[self.card_selection_var.get()]
        if self.selected_card:
            self.update_card_images()
            for attr in self.card_attributes:
                value = self.selected_card[attr] or "null"
                if isinstance(value, list):
                    value = " ".join(value)
                if isinstance(value, dict):
                    value = " ".join([f"{key}:{value}" for key, value in value.items()])
                self.card_info_entries[attr].config(state=tk.ACTIVE)
                self.card_info_entries[attr].delete(0, tk.END)
                self.card_info_entries[attr].insert(0, value)
                self.card_info_entries[attr].config(state=tk.DISABLED)

    def update_card_images(self):
        image_front = self.get_image(self.selected_card["image_front"])
        self.card_image_front.configure(image=image_front)
        self.card_image_front.image = image_front
        image_back = self.get_image(self.selected_card["image_back"])
        self.card_image_back.configure(image=image_back)
        self.card_image_back.image = image_back

    def build_card_selection_frame(self):
        self.card_selection_frame = ttk.Frame(self)
        self.card_selection_frame.pack()
        self.card_selection_label = ttk.Label(self.card_selection_frame, text="Card:")
        self.card_selection_label.pack(side=tk.LEFT)
        self.card_selection_var = tk.StringVar()
        self.card_selection = ttk.Combobox(
            self.card_selection_frame,
            textvariable=self.card_selection_var,
            width=self.card_selection_width,
        )
        self.card_selection.pack()
        self.card_selection["values"] = [card for card in self.cards]
        self.card_selection.bind("<<ComboboxSelected>>", self.load_card)

    def build_card_view_frame(self):
        self.card_view_frame = ttk.Frame(self)
        self.card_view_frame.pack()
        self.card_images_frame = ttk.Frame(self.card_view_frame)
        self.card_images_frame.pack()
        image_front = self.get_image()
        self.card_image_front = ttk.Label(self.card_images_frame, image=image_front)
        self.card_image_front.image = image_front
        self.card_image_front.pack(side=tk.LEFT)
        image_back = self.get_image()
        self.card_image_back = ttk.Label(self.card_images_frame, image=image_back)
        self.card_image_back.image = image_back
        self.card_image_back.pack(side=tk.LEFT)
        self.card_info_frame = ttk.Frame(self.card_view_frame)
        self.card_info_frame.pack(side=tk.LEFT)
        self.card_info_entries = dict()
        for attr in self.card_attributes:
            row_frame = ttk.Frame(self.card_info_frame)
            row_frame.pack(fill=tk.X)
            card_info_label = ttk.Label(row_frame, text=f"{attr.title()}:")
            self.card_info_entries[attr] = ttk.Entry(
                row_frame, text="", width=40, state=tk.DISABLED
            )
            self.card_info_entries[attr].pack(side=tk.RIGHT)
            card_info_label.pack(side=tk.RIGHT)


if __name__ == "__main__":
    CardViewer_GUI().mainloop()
