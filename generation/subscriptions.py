import random
import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import generation_func


def generate(curs, user_id):
    first_date = generation_func.generate_date()
    second_date = generation_func.generate_date()
    curs.execute("""
        INSERT INTO subscriptions (user_id, sub_level_id, start_date, end_date)
        VALUES (%s, %s, %s, %s);
    """, (user_id, random.randint(1, generation_func.sub_levels_amount), min(first_date, second_date), max(first_date, second_date))),


def generate_subscriptions(conn, n):
    print("Generating subscriptions...")
    curs = conn.cursor()
    for i in range(n):
        for _ in range(random.randint(0, 6)):
            generate(curs, i + 1)
    conn.commit()
    curs.close()
    print("Subscriptions successfully generated.")
