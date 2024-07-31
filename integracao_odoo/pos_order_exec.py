from pos_order_script import IntegracaoOdoo
# from threading import *

ord = IntegracaoOdoo()
# print("Atualizando vendas")
# Thread(ord._executando_venda(tipo='geral')).start()
ord._executando_venda(tipo='geral')
# class AtualizaProdutos:
#     _name = 'atualiza.produtos'
    
#     def __init__(self):
#         print("Atualizando produtos")
#         prd = IntegracaoOdoo()
#         prd.action_atualiza_produtos()
#         print("Atualizadossssssssssss")