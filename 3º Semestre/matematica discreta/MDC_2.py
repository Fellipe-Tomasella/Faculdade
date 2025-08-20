# O Algoritmo de Euclides para o Máximo Divisor Comum
# Entrada: Inteiros positivos a e b. Saída: mdc(a, b).
# Seja c = a mod b
# Se c = 0, retornamos a resposta b e paramos.
# caso contrário (c != 0), calculamos mdc(b, c) e consideramos isto
# como resposta.

def mdc(a, b):
    valores_b = []
    while b != 0:
        valores_b.append(b)
        a, b = b, a % b
    return a, valores_b

def mmc(a, b):
    return a * b // mdc(a, b)[0]

while True:
    num1 = int(input("Digite o primeiro número: "))
    num2 = int(input("Digite o segundo número: "))
    
    # Calcular MDC
    resultado_mdc, valores_b = mdc(num1, num2)
    print(f"O MDC de {num1} e {num2} é {resultado_mdc}")
    print(f"Valores de b utilizados: {valores_b}")
    
    # Calcular MMC
    resultado_mmc = mmc(num1, num2)
    print(f"O MMC de {num1} e {num2} é {resultado_mmc}")
    
    if input("Deseja continuar? (s/n): ").lower() == "n":
        break