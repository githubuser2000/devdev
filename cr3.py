def letter_sum_array(s):
    arr = []
    for i, c in enumerate(s):
        if c.isalpha():
            if arr:
                arr.append('+')
            arr.append(ord(c.lower()) - ord('a') + 1)
    return arr

# Alle möglichen Summierungen von n
def all_partitions(n):
    result = []
    def helper(n, path):
        if n == 0:
            result.append(path)
            return
        for i in range(1, n+1):
            helper(n-i, path + [i] + (['+'] if n-i>0 else []))
    helper(n, [])
    return result

# Summe n = ((2*n)-n) mit * und -
def special_formula(n):
    return [2, '*', n, '-', n]

# Test
s = "abc"
print("Letter sum array:", letter_sum_array(s)) # [1,'+',2,'+',3]
print("Partitions of 3:", all_partitions(3))
print("Special formula for 9:", special_formula(9))
