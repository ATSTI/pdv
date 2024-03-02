from pos_order import IntegracaoOdoo as integra



class AtualizaClientes:
    _name = 'atualiza.clientes'
    
    def __init__(self):
        print("Atualizando Clientes ...")
        integra('cliente')
        print("Atualizado.")