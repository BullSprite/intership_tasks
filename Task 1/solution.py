with open("names.txt") as file:
    names = file.read().replace("\"", "").split(",")

names.sort()
i = 0
res = 0
while i < len(names):
    nameSum = 0
    for letter in names[i]:
        nameSum += ord(letter) -  64
    res += nameSum * (i + 1)
    i += 1
print(res)