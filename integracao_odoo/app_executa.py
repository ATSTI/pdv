from tkinter import *
import tkinter as tk
# from tkinter import messagebox
import subprocess
import threading
# from pos_order_script import IntegracaoOdoo
# import queue
import datetime

class MinhaGUI():
    
    def __init__(self):
        # Criamos a janela principal
        # self.the_queue = queue.Queue()
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
        self.botaoGeral = Button(
            fm,
            text='Atualiza Vendas',
            command=lambda: threading.Thread(
                target=self.capture_output("pos_order_exec.py"), daemon=True).start()
            )
        # command=self.executando_vendas()
        # )

        # self.botaoCaixa.place(x=275, y=100)
        self.botao_sair = Button(fm, text='Sair', command=self.janela_principal.quit)
    
        # Empacotando os botoes janela principal
        self.botaoProduto.pack(side=LEFT, fill=BOTH, expand=1)
        self.botaoCliente.pack(side=LEFT, fill=BOTH, expand=1)
        self.botaoCaixa.pack(side=LEFT, fill=BOTH, expand=1)
        self.botaoGeral.pack(side=LEFT, fill=BOTH, expand=1)
        self.botao_sair.pack(side=LEFT, fill=BOTH, expand=1)
        self.labelX = tk.Label(fm, text='1')
        self.labelX.pack()
        fm.pack(fill=BOTH, expand=YES)

        # threading.Thread(
        #         target=self.capture_output("pos_order_exec.py"), daemon=True
        # ).start()
        # t = threading.Thread(target=self.capture_output("pos_order.py"), daemon=True)
        # t.start()

        # self._executando_vendas()
        # self.janela_principal.after_idle(self.executando_vendas())
        # self.the_queue.put("1")
        threading.Thread(target=self.executando_vendas).start()
        # self.janela_principal.after(1000,  self.atualizando_msg)
        # Rodando
        self.janela_principal.mainloop()
    
    # def start_new_thread(self):
    #     thread = threading.Thread(target=self._executando_vendas())
    #     thread.start()

    # def atualizando_msg(self):
    #     try:
    #         message = self.the_queue.get(block=False)
    #     except queue.Empty:
    #         # let's try again later
    #         self.janela_principal.after(1000, self.atualizando_msg)
    #         return

    #     print('Mensagem nova', message)
    #     if message is not None:
    #         # we're not done yet, let's do something with the message and
    #         # come back later
    #         self.labelX['text'] = message
    #         self.janela_principal.after(100, self.atualizando_msg)        

    def executando_vendas(self):
        # ord = IntegracaoOdoo()
        now = datetime.datetime.now()
        min = now.minute
        print("Atualizando vendas-" + now.strftime("%Y-%m-%d %H:%M:%S") + " - " + str(min))
        # message = self.the_queue.get()
        # if message is not None:
            # self.the_queue.put("1")
            # else:
        # self.num += int(message)
            # self.the_queue.put(str(self.num))
        # try:
        #     message = self.the_queue.get(block=False)
        # except queue.Empty:
        #     # let's try again later
        #     # self.janela_principal.after(100, self.executando_vendas)
        #     return
        # if message is not None:
        #     # we're not done yet, let's do something with the message and
        #     # come back later
            # self.labelX['text'] = "2"
        # else:
            # self.labelX['text'] = "1"
            # self.janela_principal.after(100, self.executando_vendas)
        # if self.num == 1:
        # self.the_queue.put(str(self.num+1))
        # else:
            # self.the_queue.put(str(self.num+5))
        th = threading.Thread(target=self.capture_output("pos_order_exec.py"), daemon=True)
        th.start()
        if min > 20 and min < 30:
            th = threading.Thread(target=self.capture_output("atualiza_produtos.py"), daemon=True)
            th.start()
            th = threading.Thread(target=self.capture_output("atualiza_clientes.py"), daemon=True)
            th.start()
            th = threading.Thread(target=self.capture_output("atualiza_caixas.py"), daemon=True)
            th.start()
        if min > 40 and min < 50:
            th = threading.Thread(target=self.capture_output("atualiza_produtos.py"), daemon=True)
            th.start()
        if min < 10:
            th = threading.Thread(target=self.capture_output("atualiza_produtos.py"), daemon=True)
            th.start()

        # 600000 = 10 min.
        self.janela_principal.after(600000, self.executando_vendas)

    def capture_output(self, script=None):
        # "python -u" make stdout stream to be unbuffered
        p = subprocess.Popen(["python", "-u", script], stdout=subprocess.PIPE)
        while p.poll() is None: # process is still running
            self.logbox.insert("end", p.stdout.readline())
            self.logbox.see("end")
        self.logbox.insert("end", "--- feito. ---\n")


gui = MinhaGUI()
