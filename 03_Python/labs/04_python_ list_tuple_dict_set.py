## Section 1: Lists, Tuples, Dicts, and Sets

#1. Create a list of 5 product names; print the first and last using indices.

products = ['cake', 'pie', 'tea', 'coffee', 'juice']
print("1." f"First: {products[0]}, Last: {products[-1]}")  #list indexing

#2.Create a tuple of customer names. Convert it to a list, 
# add a new name, and convert it back to a tuple.

customers = ("Carmen", "Jorge", "Egle", "Alessia")
temp_list = list(customers)  #convert
temp_list.append("Vyta")  #append
customers = tuple(temp_list)  #convert back
print("2.", customers)

#3.You have a list of prices [10, 20, 15, 30]. 
# Convert it to a set and show how many unique prices there are using set() and len().

prices = [10, 20, 15, 30, 30, 30]
new_set = set(prices)
print("3.", "Unique prices:", {len(new_set)})

#4.Create a dictionary (dict) with product names as keys and sales counts as values. 
# Change the value of one product using indexing.

sale = {"Book": 34, "Libreta": 45, "Pen": 12}
sale["Libreta"] = 54
print("4.", sale)

#5.You have list = ["A", "B", "C"] and set = {"B", "C", "D"}. 
# Find the common elements using intersection.

list_a = ["A", "B", "C"]
set_b = {"B", "C", "D"}
common = set(list_a).intersection(set_b)
print("5.", common)

#6.Create a tuple with monthly profits (12 values). 
# Calculate the average profit using sum() and len().

monprofits = (123, 345, 567.57548765, 890, 135, 246, 579, 987, 654, 432, 192, 409)
profit_avg = round(sum(monprofits) / len(monprofits), 2)
print("6.", "Average monthly profit:", profit_avg)

#7.Create a dict where keys are months and values are profits. Calculate the sum of all months.

monthlyprof = {"Jan": 2272736253, "Feb": 758754865, "Mar": 131313, "Apr": 222222, "May": 46573657, "June": 121212}
avg_month_prof = sum(monthlyprof.values())
print("7.", "Bendra suma:", avg_month_prof, "EUR")

#8.Create a list of purchase dates as strings (e.g., '2023-01-01') and convert them to 
# datetime objects using strptime.

from datetime import datetime, date

purchase_date = ["2023-02-23", "2024-12-23", "2023-11-17"]
purchase_obj = [datetime.strptime(d, '%Y-%m-%d') for d in purchase_date]


#9.Calculate how many days have passed from each purchase date until today.

today = datetime.today()
for d in purchase_obj:
    days_diff = (today - d).days
    print("8-9.", f"Days passed since {d}: {days_diff}")

#10.Create a dict where keys are product names and values are lists of monthly sales. 
# Find the total sum for each product using a for loop and sum().

sales = {
    "Camomile": [12, 16, 22],
    "Green Tea": [23, 22, 11],
    "Roibos": [33, 54, 11]
    }

for products, monthly_sales in sales.items():
    print("10.", f"{products} montly sales: {sum(monthly_sales)}")

