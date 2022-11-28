import tkinter as tk


class DisabledEntry(tk.Entry):
    def __init__(self, *args, **kwargs):
        super().__init__(
            *args,
            disabledbackground="white",
            disabledforeground="black",
            state=tk.DISABLED,
            **kwargs,
        )


if __name__ == "__main__":
    main_window = tk.Tk()
    main_window.title("DisabledEntry")
    width: int = 250
    height: int = 50
    main_window.geometry(f"{width}x{height}")

    frame = tk.Frame(main_window)
    frame.pack()

    entry_text_var = tk.StringVar()
    entry_text_var.set("You can't change this")
    disabled_entry = DisabledEntry(frame, textvariable=entry_text_var)
    disabled_entry.pack()

    main_window.mainloop()
