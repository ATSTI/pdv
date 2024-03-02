from pos_order import IntegracaoOdoo as integra



class AtualizaProdutos:
    _name = 'atualiza.produtos'
    
    def __init__(self):
        print("Atualizando produtos")
        integra('produto')
        print("Atualizadossssssssssss")