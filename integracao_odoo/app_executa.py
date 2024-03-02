from tkinter import *
import tkinter as tk
# from tkinter import messagebox
import subprocess
import threading

class MinhaGUI():
    
    def __init__(self):
        # Criamos a janela principal
        self.janela_principal = Tk()
    
        self.logbox = tk.Text(self.janela_principal, width=80, height=20)
        self.logbox.pack()

        # Criando os botões
        self.botaoProduto = Button(
            self.janela_principal,
            text='Atualiza Produtos',
            command=lambda: threading.Thread(
                target=self.capture_output("atualiza_clientes.py"), daemon=True).start()
            )
        self.botaoCliente = Button(self.janela_principal, text='Atualiza Clientes', command=self.capture_output('atualiza_clientes.py'))
        self.botao_sair = Button(self.janela_principal, text='Sair', command=self.janela_principal.quit)
    
        # Empacotando os botões janela principal
        self.botaoProduto.pack()
        self.botaoCliente.pack()
        self.botao_sair.pack()
    
        # Rodando
        mainloop()

    def capture_output(self, script=None):
        # "python -u" make stdout stream to be unbuffered
        p = subprocess.Popen(["python", "-u", script], stdout=subprocess.PIPE)
        while p.poll() is None: # process is still running
            self.logbox.insert("end", p.stdout.readline())
            self.logbox.see("end")
        self.logbox.insert("end", "--- feito. ---\n")

    # def hello_world(self):
    # messagebox.showinfo('Adoro a Apostila Python Progressivo!')


gui = MinhaGUI()
