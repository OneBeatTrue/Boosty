import random
import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import generation_func


def generate(curs, user_id):
    curs.execute("""
        INSERT INTO billings (user_id, currency_id, card_number, valid_until, cardholder_name, cvv, bank_type_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s);
    """, (user_id, random.randint(1, 4), generation_func.generate_card_number(), generation_func.generate_date(), generation_func.generate_name(), generation_func.generate_cvv(), random.randint(1, 2)))


def generate_billings(conn, n):
    print("Generating billings...")
    curs = conn.cursor()
    for i in range(n):
        for _ in range(random.randint(0, 2)):
            generate(curs, i + 1)
    conn.commit()
    curs.close()
    print("Billings successfully generated.")
