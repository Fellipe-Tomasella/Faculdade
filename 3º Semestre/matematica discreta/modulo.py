def gerar_tabela_multiplicacao_modular(n):
    """
    Gera uma tabela de multiplicação modular para Zn.
    
    Args:
        n (int): O módulo
    
    Returns:
        list: Matriz representando a tabela
    """
    # Cabeçalho da tabela
    tabela = [["⊗"] + [str(i) for i in range(n)]]
    
    # Preenche as linhas da tabela
    for a in range(n):
        linha = [str(a)]  # Adiciona o primeiro elemento da linha (multiplicador)
        for b in range(n):
            # Calcula a multiplicação modular
            resultado = (a - b) % n
            linha.append(str(resultado))
        tabela.append(linha)
    
    return tabela

def imprimir_tabela(tabela):
    """
    Imprime a tabela de forma formatada.
    """
    # Determina a largura de cada coluna
    col_width = max(len(word) for row in tabela for word in row) + 2
    
    # Imprime a tabela
    for row in tabela:
        print("".join(word.ljust(col_width) for word in row))

# Permitir que o usuário escolha o valor de n
if __name__ == "__main__":
    while True:
        try:
            n = int(input("Digite o valor de n para gerar a tabela de multiplicação modular (Zn) ou 0 para sair: "))
            if n == 0:
                print("Encerrando o programa.")
                break
            elif n < 0:
                print("Por favor, insira um número inteiro positivo.")
            else:
                tabela = gerar_tabela_multiplicacao_modular(n)
                imprimir_tabela(tabela)
        except ValueError:
            print("Entrada inválida. Por favor, insira um número inteiro.")