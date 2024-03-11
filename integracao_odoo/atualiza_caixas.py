from pos_order import IntegracaoOdoo as integra



class AtualizaCaixas:
    _name = 'atualiza.caixas'
    
    def __init__(self):
        print("Atualizando Caixas ...")
        integra('caixa')
        print("Atualizado.")