from tkinter import *
import tkinter as tk
# from tkinter import messagebox
import subprocess
import threading

class MinhaGUI():
    
    def __init__(self):
        # Criamos a janela principal
        self.janela_principal = Tk()
        self.janela_principal.title("Atualizar Servidor")
        self.janela_principal.option_add('*font', ('verdana', 12, 'bold'))
        self.janela_principal.geometry("800x600")

        fm = Frame(self.janela_principal, background="tan",
            borderwidth=5,  relief=RIDGE,
            width=250,)

        self.logbox = tk.Text(self.janela_principal, width=60, height=30)
        self.logbox.pack()

        # Criando os botoes
        self.botaoProduto = Button(
            fm,
            text='Atualiza Produtos',
            command=lambda: threading.Thread(
                target=self.capture_output("atualiza_produtos.py"), daemon=True).start()
            )
        # self.botaoProduto.place(x=75, y=50)
        self.botaoCliente = Button(
            fm,
            text='Atualiza Clientes',
            command=lambda: threading.Thread(
                target=self.capture_output("atualiza_clientes.py"), daemon=True).start()
            )
        # self.botaoCliente.place(x=5, y=10)
        self.botaoCaixa = Button(
            fm,
            text='Atualiza Caixas',
            command=lambda: threading.Thread(
                target=self.capture_output("atualiza_caixas.py"), daemon=True).start()
            )
        # self.botaoCaixa.place(x=275, y=100)
        self.botao_sair = Button(fm, text='Sair', command=self.janela_principal.quit)
    
        # Empacotando os botoes janela principal
        self.botaoProduto.pack(side=LEFT, fill=BOTH, expand=1)
        self.botaoCliente.pack(side=LEFT, fill=BOTH, expand=1)
        self.botaoCaixa.pack(side=LEFT, fill=BOTH, expand=1)
        self.botao_sair.pack(side=LEFT, fill=BOTH, expand=1)
    
        fm.pack(fill=BOTH, expand=YES)

        # Rodando
        mainloop()

    def capture_output(self, script=None):
        # "python -u" make stdout stream to be unbuffered
        p = subprocess.Popen(["python", "-u", script], stdout=subprocess.PIPE)
        while p.poll() is None: # process is still running
            self.logbox.insert("end", p.stdout.readline())
            self.logbox.see("end")
        self.logbox.insert("end", "--- feito. ---\n")


gui = MinhaGUI()
