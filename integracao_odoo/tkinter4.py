import tkinter as tk
import subprocess
import threading

root = tk.Tk()

logbox = tk.Text(root, width=80, height=20)
logbox.pack()

def capture_output(script=None):
    # "python -u" make stdout stream to be unbuffered
    p = subprocess.Popen(["python", "-u", script], stdout=subprocess.PIPE)
    while p.poll() is None: # process is still running
        logbox.insert("end", p.stdout.readline())
        logbox.see("end")
    logbox.insert("end", "--- feito. ---\n")

# use thread so that it won't block the application
tk.Button(root, 
          text=" Atualiza Produtos ", 
          command=lambda: threading.Thread(
              target=capture_output("atualiza_produtos.py"), daemon=True).start()).pack()
tk.Button(root, 
          text=" Atualiza Clientes ", 
          command=lambda: threading.Thread(
              target=capture_output("atualiza_clientes.py"), daemon=True).start()).pack()

root.mainloop()