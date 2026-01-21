#### Problem 1

# Write code that:
#- Allows the user to input numbers a and b (int or float)
#- Prints "a is less than b" if that is true
#- Prints "a is equal to b" if that is true
#- Prints "a is greater than b" if that is true

#  Tip: Use input, if, elif, and else statements

a = int(input("Enter the first number: "))
b = int(input("Enter the second number: "))

print(...)

if a < b:
    print(f"{a} is less than {b}")
elif a > b:
    print(f"{a} is greater than {b}")
else:
    print(f"{a} is equal to {b}")