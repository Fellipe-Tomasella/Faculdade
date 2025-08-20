def eh_seguro(escola, sala, horario):
    # Verifica se já tem um professor no mesmo horário (coluna)
    for i in range(sala):
        if escola[i][horario] == 1:
            return False

        # Verifica conflito na diagonal esquerda
        if horario - (sala - i) >= 0 and escola[i][horario - (sala - i)] == 1:
            return False

        # Verifica conflito na diagonal direita
        if horario + (sala - i) < len(escola) and escola[i][horario + (sala - i)] == 1:
            return False

    return True


def alocar_professores(escola, sala):
    if sala == len(escola):
        return True  # Todos os professores foram alocados

    for horario in range(len(escola)):
        if eh_seguro(escola, sala, horario):
            escola[sala][horario] = 1  # Aloca o professor
            if alocar_professores(escola, sala + 1):
                return True
            escola[sala][horario] = 0  # Backtracking (remove o professor)

    return False


def imprimir_horario(escola):
    print("\n Tabela de Alocação de Professores (Salas x Horários):\n")
    for sala in range(len(escola)):
        linha = ""
        for horario in range(len(escola)):
            if escola[sala][horario] == 1:
                linha += " P "  # P = Professor
            else:
                linha += " . "  # . = vazio
        print(f"Sala {sala+1}: {linha}")
    print("\n locação concluída com sucesso!\n")


def main():
    while True:
        try:
            n = int(input("Digite o número de professores (e também o número de salas e horários): "))
            if n <= 0:
                print(" Por favor, digite um número positivo maior que zero.")
                continue
            break
        except ValueError:
            print(" Entrada inválida. Digite um número inteiro.")

    escola = [[0 for _ in range(n)] for _ in range(n)]

    print("\n Iniciando alocação dos professores...")
    sucesso = alocar_professores(escola, 0)

    if sucesso:
        imprimir_horario(escola)
    else:
        print("Não foi possível alocar os professores sem conflito.")


if __name__ == "__main__":
    main()