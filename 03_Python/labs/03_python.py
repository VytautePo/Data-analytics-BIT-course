# 03 set of Python tasks
#datetime, try/except/finally, boolean

#1.create today's date

import calendar
import datetime

today = datetime.date.today()
print("1) Today:", today)

#2.Create the date June 1, 2023 and print it.

day = datetime.date(2023, 6, 1)
print("2) Diena:", day)

#3. Convert string to datetime object (datetime)

string_day = "2022-12-25"
convert_datetime = datetime.datetime.strptime(string_day, "%Y-%m-%d")
print("3) Konvertuota data yra:", convert_datetime, "| type:", type(convert_datetime))

#4. Print which day of the week was 2022-12-25.

day_of_week = "2022-12-25"
conv_day = datetime.datetime.strptime(day_of_week, "%Y-%m-%d")
print("4) Savaites diena:", conv_day.strftime('%A'))

#4.1 with lithuanian locale

import locale

# nustatome lietuvišką lokalę
locale.setlocale(locale.LC_TIME, 'lt_LT.UTF-8')

date_str = "2022-12-25"
date_obj = datetime.datetime.strptime(date_str, "%Y-%m-%d")

print("4.1) Savaitės diena:", date_obj.strftime('%A'))

#4.2 without locale, student friendly and not dependent on OS


days_lt = {
    0: "pirmadienis",
    1: "antradienis",
    2: "trečiadienis",
    3: "ketvirtadienis",
    4: "penktadienis",
    5: "šeštadienis",
    6: "sekmadienis"
}

date_obj = datetime.datetime.strptime("2022-12-25", "%Y-%m-%d")
print("4.2) Savaitės diena:", days_lt[date_obj.weekday()])

#5. Calculate the difference in days between 2023-01-01 and 2023-02-01

first_day_str = "2022-12-25"
second_day_str = "2023-02-01"

first_day_obj = datetime.datetime.strptime(first_day_str, "%Y-%m-%d")
second_day_obj = datetime.datetime.strptime(second_day_str, "%Y-%m-%d")

skirtumas_delta = second_day_obj - first_day_obj

print("5) Difference between the two days:", skirtumas_delta.days)

#5.1 simpler shorter version
start = datetime.date(2023, 1, 1)
end = datetime.date(2023, 2, 1)
diff_days = (end - start).days
print("5.1) Difference in days:", diff_days)

#6. Create a loop that prints the 1st day of each month in 2023

#range(1, 13)

for month in range(1, 13):
    print("6) Pirma 2023 metu diena kas menesi:", datetime.date(2023, month, 1))

# with a weekday

for month in range(1, 13):
    date_obj = datetime.date(2023, month, 1)
    print("6.1) Pirma diena su savaites diena:", 
        date_obj,
        date_obj.strftime("%A")
    )
    
#7. Check whether two dates (2023-03-05 and 2023-03-20) belong to the same month.

a = datetime.date(2023, 3, 5)
b = datetime.date(2023, 3, 20)

same_month = (a.year == b.year) and (a.month == b.month)
print("7) Same month:", same_month)

#8 Convert today’s date to a text format YYYY-MM-DD.

today = datetime.date.today()
conv_today = today.strftime("%Y-%B-%d")
print("8) Today in string:", conv_today)

#9. Create date from variables
year = 2024
month = 12
day = 31
date_created = datetime.date(year, month, day)
print("9) Date from variables:", date_created)

#10. Check if a given day is weekend (2023-03-18)

def weekend_or_not (date_obj: datetime.date) -> bool:
    return date_obj.weekday() >= 5

test_date = datetime.date(2026, 1, 31)
print("10) Is it weekend?", test_date, "->", weekend_or_not(test_date))



## Tasks with try/except/finally:

#11. Write code that divides 10 by 0 and handles ZeroDivisionError.

try:
    result = 10 /0

except ZeroDivisionError:
    print("11) Cannot divide by 0!")
    

#12. Try to open a non-existent file and handle FileNotFoundError.

try:
    with open("non_existing_file.csv") as f:
        content = f.read()
except FileNotFoundError:
    print("12) File not found!")

#13. Try to convert the text 'abc' to int and handle ValueError.

try:
    x = int("abc")
except ValueError:
    print("13) Cannot convert 'abc' to int!")

#14. Use try/except/finally – even if there is an error, finally must print 'Finished'.

try:
    y = 10 / 0
except ZeroDivisionError:
    print("14.a) Error happened.")
finally:
    print("14.b) Baigta")

#15. Create code where two possible errors may occur: division by 0 and invalid conversion.

try:
    num = int("abc")     # ValueError
    z = 10 / 0           # ZeroDivisionError (won't reach if previous fails)
except ValueError:
    print("15) Invalid conversion to int.")
except ZeroDivisionError:
    print("15) Division by zero.")

#16. Read a number as text, convert it to int with try/except.

text_number = "123"  # (imituojam įvedimą)
try:
    n = int(text_number)
    print("16.a) Converted:", n)
except ValueError:
    print("16.b) Not a valid integer.")

#17. Create a function that raises an error if the entered number is negative.

def check_positive(n: int) -> None:
    if n < 0:
        raise ValueError("Number must be non-negative!")

try:
    check_positive(-5)
except ValueError as e:
    print("17)", e)

#18. Use an else block – if there is no error, print 'All good'.

try:
    value = int("42")
except ValueError:
    print("18) Error converting.")
else:
    print("18) Viskas gerai")

#19. Check whether the file 'duomenys.txt' exists – if not, print a friendly message.

import os

filename = "pvz.jpg"
if os.path.exists(filename):
    print("19) File exists:", filename)
else:
    print("19) File does not exist:", filename)

#20. Create a loop with try/except that tries to divide 100 by numbers in a list, 
# where one of them is 0.

numbers = [10, 5, 0, 2]
print("10) Divisions:")
for num in numbers:
    try:
        print(" 100 /", num, "=", 100 / num)
    except ZeroDivisionError:
        print(" 100 /", num, "= Cannot divide by zero!")


## Boolean tasks:

# 1. sentence = "Big data yra svarbi šiuolaikinei analitikai"
#Check if the word "data" is in the sentence variable.



#2. Check if the name 'Asta' is in the list names = ['Jonas', 'Asta', 'Tomas'].



#3. Does the word 'Python' start with the letter 'P'?



#4. Does the word 'analitika' end with the letter 'a'?



#5. Does the sentence 'Python yra naudingas' contain the word 'naudingas'?



#6. Is the number 5 in the list skaiciai = [1, 2, 3, 4, 5, 6]?



#7. Is user['logged_in'] True if user = {'name': 'Jonas', 'logged_in': True}?



#8. Check whether the list zodziai = ['duomenys', 'analizė', 'python'] contains at least one word longer than 7 characters.



#9. Is x > 10 and x < 20 true if x = 15?



#10/ Create a variable email = 'jonas@example.com'
# Check if email contains the '@' symbol.