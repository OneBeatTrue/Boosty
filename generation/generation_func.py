import datetime
import hashlib
# import os
import string
import random
from datetime import date

creators_dict = dict()
sub_levels_amount = 0
posts_amount = 0


def generate_name():
    return ''.join(random.choices(string.ascii_letters, k=10))


def generate_phone_number():
    return random.randint(1000000000, 9999999999)


def generate_email():
    return ''.join(random.choices(string.ascii_lowercase, k=5)) + "@itmo.com"


def generate_bytea():
    return bytes(random.randint(0, 255) for _ in range(10))


def generate_password():
    return hashlib.sha256(
        ''.join(random.choices(string.ascii_letters + string.digits, k=10)).encode('utf-8')).hexdigest()


def generate_string():
    return ''.join(random.choice(string.ascii_letters) for _ in range(10))


def generate_card_number():
    return random.randint(1000000000000000, 9999999999999999)


def generate_date():
    return date(random.randint(2015, 2024), random.randint(1, 12), random.randint(1, 28))


def generate_cvv():
    return random.randint(100, 999)


def generate_percent():
    return random.uniform(0, 100)


def generate_money():
    return random.randint(1, 100000) / 100


def generate_datetime():
    start_year = 2015
    end_year = 2024
    start_date = datetime.datetime(start_year, 1, 1)
    end_date = datetime.datetime(end_year, 12, 31)
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    random_seconds = random.randint(0, 24 * 60 * 60 - 1)
    return start_date + datetime.timedelta(days=random_days, seconds=random_seconds)


def generate_text():
    length = random.randint(1, 10)
    return ''.join(random.choices(string.ascii_letters + string.digits + string.punctuation + ' ', k=length))


def generate_tag():
    tags = ["#video", "#photo", "#gif", "#music", "#text"]
    return random.choice(tags)

# class Generator:
#     def __init__(self, connection):
#         self.connection = connection
#
#     def execute(self):
#         cursor = self.connection.cursor()
#         cursor.execute("temp.sql")
#         cursor.commit()
#         os.remove("temp.sql")
#
#     def generate(self, data):
#         pass