import platform
import tkinter as tk
import subprocess
from pathlib import Path

class App(tk.Tk):
    entry = None
    text = None

    def __init__(self):
        tk.Tk.__init__(self)
        
        self.geometry("400x50+500+300")
        self.attributes("-topmost", True)

        if platform.system() == "Linux":
            self.attributes("-type", "notification")
        else:
            self.overrideredirect(True)

        # all stuff so that we can focus
        self.configure(bg = "#222222")
        self.focus_force()
        self.lift()
        self.update()

        self.text = tk.StringVar()
        self.entry = tk.Entry(self, textvariable = self.text)

        self.entry.pack(fill = tk.BOTH, expand = True, padx = 10, pady = 10)
        self.entry.bind("<Return>", self.on_save)
        self.entry.bind("<Escape>", self.close)
        self.entry.focus()

        self.mainloop()

    def on_save(self, event):
        command = self.text.get().strip()
        print(f"running command {command}")
        if command:
            if platform.system() == "Darwin":
                subprocess.Popen(["shortcuts", "run", command], stderr=subprocess.DEVNULL)
                #subprocess.run(["open", "-a", command], stderr=subprocess.DEVNULL)
            if platform.system() == "Linux":
                subprocess.Popen([command], stderr=subprocess.DEVNULL)
        self.clear()
        self.close(None)

    def search(self):
        f"{Path.home()}/Applications"

    def clear(self):
        self.text.set("")

    def close(self, event):
        if self.text.get():
            self.clear()
        else:
            self.destroy()

App()

