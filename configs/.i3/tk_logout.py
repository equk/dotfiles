#!/usr/bin/env python

"""

*****************************************************************
                tk_logout.py - equk.co.uk
*****************************************************************
Copyright (C) 2014  Bradley Walden
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions. See GNU GPLv3.
*****************************************************************
Brings up a logout / shutdown dialog for i3wm
*****************************************************************
Dependencies: Python3, Tkinter
Notes: add the line below to your i3 config to enable a floating window

for_window [class="Tk" title="tk_logout"] floating enable, border 1pixel

"""

import tkinter as tk
import os


def shutdown():
    os.system("systemctl poweroff")


def reboot():
    os.system("systemctl reboot")


def logout():
    os.system("i3-msg exit")

app = tk.Tk()
app.title("tk_logout")

shutdown_button = tk.Button(app, text="Shutdown", command=shutdown)
shutdown_button.pack(side='left', padx=5, pady=5)

logout_button = tk.Button(app, text="Logout", command=logout)
logout_button.pack(side='left', padx=5, pady=5)

reboot_button = tk.Button(app, text="Reboot", command=reboot)
reboot_button.pack(side='left', padx=5, pady=5)

close_button = tk.Button(app, text="Close", command=exit)
close_button.pack(side='left', padx=5, pady=5)

app.mainloop()
