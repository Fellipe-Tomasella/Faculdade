def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

def find_primes_up_to(n):
    primes = []
    for i in range(2, n + 1):
        if is_prime(i):
            primes.append(i)
    return primes

# Example usage
number = int(input("Escreva o numero final: "))
primes = find_primes_up_to(number)
print(f"Numeros primos até o numero {number}: {primes}")