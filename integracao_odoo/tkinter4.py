import tkinter as tk
import subprocess
import threading

root = tk.Tk()

logbox = tk.Text(root, width=80, height=20)
logbox.pack()

def capture_output():
    # "python -u" make stdout stream to be unbuffered
    p = subprocess.Popen(["python", "-u", "atualiza_produtos.py"], stdout=subprocess.PIPE)
    while p.poll() is None: # process is still running
        logbox.insert("end", p.stdout.readline())
        logbox.see("end")
    logbox.insert("end", "--- feito. ---\n")

# use thread so that it won't block the application
tk.Button(root, text=" Atualiza Produtos ", command=lambda: threading.Thread(target=capture_output, daemon=True).start()).pack()

root.mainloop()