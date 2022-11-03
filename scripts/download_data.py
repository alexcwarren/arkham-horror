import json
import re

import requests
from bs4 import BeautifulSoup


class ProgressBar:
    def __init__(
        self,
        total,
        iteration=0,
        prefix="",
        suffix="",
        decimals=1,
        length=50,
        fill="█",
        print_end="\r",
    ):
        self.iteration: int = iteration
        self.total: int = total
        self.prefix: str = prefix
        self.suffix: str = suffix
        self.decimals: int = decimals
        self.length: int = length
        self.fill: str = fill
        self.print_end: str = print_end

    def print(self):
        """
        Call in a loop to create terminal progress bar
        @params:
            iteration   - Required  : current iteration (Int)
            total       - Required  : total iterations (Int)
            prefix      - Optional  : prefix string (Str)
            suffix      - Optional  : suffix string (Str)
            decimals    - Optional  : positive number of decimals in percent complete (Int)
            length      - Optional  : character length of bar (Int)
            fill        - Optional  : bar fill character (Str)
            print_end    - Optional  : end character (e.g. "\r", "\r\n") (Str)
        """
        percent = ("{0:." + str(self.decimals) + "f}").format(
            100 * (self.iteration / float(self.total))
        )
        filledLength = int(self.length * self.iteration // self.total)
        bar = self.fill * filledLength + "-" * (self.length - filledLength)
        print(f"\r{self.prefix} |{bar}| {percent}% {self.suffix}", end=self.print_end)
        self.iteration += 1
        # Print New Line on Complete
        if self.iteration == self.total:
            print()


def download_card_images(start: int, end: int):
    path: str = "../data/card-images/"
    for i in range(start, end + 1):
        progress_bar.print()
        for suffix in ("", "b"):
            filename: str = f"01{i:03d}{suffix}.png"
            image_url: str = f"https://arkhamdb.com/bundles/cards/{filename}"
            image_request = requests.get(image_url)
            if image_request.status_code == 200:
                with open(f"{path}{filename}", "wb") as handler:
                    handler.write(image_request.content)


def get_td_text(content: BeautifulSoup, tag: str, value: str):
    element = content.find("td", attrs={tag: value})
    return element.text.strip()


def get_datath_text(content: BeautifulSoup, value: str):
    return get_td_text(content, "data-th", value)


def download_cards_data(data_url: str):
    path: str = "../data/"
    # Initialize cards data
    NULL = None
    cards_data: dict = dict()
    cards_data["skill-icons"] = ["Willpower", "Intellect", "Combat", "Agility", "Wild"]
    cards_data["classes"] = list()
    cards_data["types"] = list()
    cards_data["traits"] = list()
    cards_data["sets"] = list()
    # Request content from URL
    # data_url: str = "https://arkhamdb.com/set/core"
    data_page = requests.get(data_url)
    soup = BeautifulSoup(data_page.content, "html.parser")
    results = soup.find_all("tr", class_=re.compile(r"[odd|even]"))
    # results.extend(soup.find_all("tr", class_="even"))
    # Parse resulting content
    for result in results:
        progress_bar.print()
        card_data: dict = dict()
        # Name: str
        name_td = result.find("td", attrs={"data-th": "Name"})
        name: str = name_td.find("a").text.strip()
        # Class: str
        faction: str = get_datath_text(result, "Faction")
        card_data["class"] = faction
        if faction not in cards_data["classes"]:
            cards_data["classes"].append(faction)
        # Cost: int / null
        cost: str = get_datath_text(result, "Cost")
        card_data["cost"] = int(cost) if cost else NULL
        # Level: int / null
        level_span = name_td.find("span", string=re.compile(r"\(\d\)"))
        level: str = ""
        if level_span:
            level = re.search(r"\d", level_span.text.strip()).group()
        card_data["level"] = int(level) if level else NULL
        # Type: str
        type: str = get_datath_text(result, "Type")
        if type not in cards_data["types"]:
            cards_data["types"].append(type)
        card_data["type"] = type
        # Icons: Dict<str, int> / null
        icons_td = result.find("td", attrs={"data-th": "Stats"})
        icons: dict[str:int] = dict()
        for skill in cards_data["skill-icons"]:
            icon_spans = icons_td.find_all("span", attrs={"title": skill})
            if icon_spans:
                icons[skill] = len(icon_spans)
        card_data["icons"] = icons if icons else NULL
        # Traits List<str> / null
        traits: str = get_datath_text(result, "Traits").replace(".", "").split(" ")
        for trait in traits:
            if trait and trait not in cards_data["traits"]:
                cards_data["traits"].append(trait)
        card_data["traits"] = traits if traits[0] else NULL
        # Set: str
        set_number: str = get_datath_text(result, "Set").split(" ")
        set: str = " ".join(set_number[:-1])
        if set not in cards_data["sets"]:
            cards_data["sets"].append(set)
        card_data["set"] = set
        # Number: int
        number: str = set_number[-1]
        card_data["number"] = int(number)
        # Encounter: str / null
        encounter: str = " ".join(get_datath_text(result, "Encounter").split(" ")[:-1])
        card_data["encounter"] = encounter if encounter else NULL
        # Image front: str
        image_name_atag = name_td.find("a")
        image_name: str = image_name_atag["href"].split("/")[-1]
        card_data["image_front"] = f"{image_name}.png"
        # Image back: str
        card_data["image_back"] = NULL
        if type in ["Investigator", "Scenario", "Agenda", "Act", "Location"]:
            card_data["image_back"] = f"{image_name}b.png"
        elif type in ["Asset", "Event", "Skill"]:
            card_data["image_back"] = f"player-card-back.png"
        elif type == "Enemy":
            card_data["image_back"] = f"encounter-card-back.png"
        elif type == "Treachery":
            if card_data["encounter"] == NULL:
                card_data["image_back"] = f"player-card-back.png"
            else:
                card_data["image_back"] = f"encounter-card-back.png"
        # Store data
        cards_data[name] = card_data
        # Sort (if desired)
        cards_data["traits"] = sorted(cards_data["traits"])
    # Save data into json file
    with open(f"{path}cards.json", "w") as write_file:
        json.dump(cards_data, write_file)


if __name__ == "__main__":
    # progress_bar = ProgressBar(2 * 182)
    # progress_bar.print()
    # download_card_images(1, 182)
    progress_bar = ProgressBar(182)
    progress_bar.print()
    download_cards_data("https://arkhamdb.com/set/core")
