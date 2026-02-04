### Section 2: Function Creation (Data Analytics)

#1. Function that returns a number multiplied by 2.

numbers = [1, 3, 5, 7, 9]

def multiplied_numbers(data_list):
    return[x * 2 for x in data_list]

result = multiplied_numbers(numbers)
print("1.", "Multiplied numbers:", result)

#2. Function to calculate Conversion Rate: (buyers / users) * 100.


def Conversion_rate(buyers, users):
    if users == 0:
        return 0.0
    return round((buyers / users) * 100, 2)

print("2.", "Conversion rate:", Conversion_rate(67, 87))

#3. Function to calculate CTR: (clicks / impressions) * 100.

def click_trough_rate(clicks, impressions):
    if impressions == 0:
        return 0.0
    return round((clicks / impressions) * 100, 2)

print("3.", "CTR:", click_trough_rate(234, 654))

#4. Function to calculate the average of a list.

apple_prices = [2, 5, 5.6, 7]

def avg_apple_price(prices_list):
    return round(sum(apple_prices) / len(apple_prices), 2)

print("4.", "Average apple price:", avg_apple_price(apple_prices))

#5. Function that returns the difference between two numbers (to calculate monthly change).

a = 56
b = 989

def difference_between_the_two(num_a, num_b):
    return num_b - num_a

print("5.", "Delta:", difference_between_the_two(a, b))


#6. Function that takes lists of revenue and expenses and returns the net profit for each period.

rev_a = [1234, 1256, 1238, 1453]
exp_a = [345, 567, 789, 1111]

def net_profit_per_period(revenue, expenses):
    return [r - e for r, e in zip(revenue, expenses)]

print("6.", "Net Profit:", net_profit_per_period(rev_a, exp_a))

#7. Function that counts how many times the value 'inactive' appears in a list.

attendence_list = ['active', 'active', 'inactive', 'active', 'inactive']

def count_inactive(status_list):
    return status_list.count('inactive')

print("7.", "Inactive employes:", count_inactive(attendence_list))

#8. Function that takes a dict of sales by region and returns the region with the maximum sales.

sales_data = {'Vilnius': 5000, 'Kaunas': 7000, 'Klaipėda': 4500}

def best_region(data_dict):
    return max(data_dict, key=data_dict.get)

print("8. The best region:", best_region(sales_data))

#8.1 different sample data

rota_hours = {
    'Jonas': 160,
    'Asta': 172,
    'Mantas': 155,
    'Eglė': 180,
    'Darius': 140
}
def top_performer(data_dictio):
    return max(data_dictio, key=data_dictio.get)

print("8.1. Top worker is", top_performer(rota_hours))

#9. Function that returns True if profit is positive, otherwise False.

def is_profitable(amount):
    return amount > 0

print("9. The sale was profitable:", is_profitable(-67))

#10. Function that converts a list of date strings into datetime objects.

from datetime import datetime, date

date_str = ['1989-05-26', '1989-07-19', '1994-02-01', '1984-11-05', '1982-02-04']

def convert_str_to_datetime(str_list):
    return [datetime.strptime(d, '%Y-%m-%d') for d in str_list]

result = convert_str_to_datetime(date_str)
print("10. Datetime objects:", result)