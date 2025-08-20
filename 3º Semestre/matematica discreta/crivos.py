n = int(input("Digite a quantidade de números 'n': "))
numeros = list(range(2, n + 1))  

print("Lista inicial:", numeros)

for i in range(len(numeros)):
    atual = numeros[i]

    if atual is not None:  
        for j in range(i + 1, len(numeros)):
            proximo = numeros[j]
            
            if proximo is not None and proximo % atual == 0:  
                numeros[j] = None

numeros_primos = []

for i in range (len(numeros)):
    if numeros[i] is not None:
        numeros_primos.append(numeros[i])
    

print("Números primos:", numeros_primos)
print("Quantidade de números 1:", len(numeros_primos))