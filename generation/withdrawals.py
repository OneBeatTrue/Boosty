import random
import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import generation_func


def generate(curs, creator_id):
    curs.execute("""
        INSERT INTO withdrawals (creator_id, withdrawal_system_id, datetime, amount)
        VALUES (%s, %s, %s, %s);
    """, (creator_id, random.randint(1, 3), generation_func.generate_datetime(), generation_func.generate_money()))


def generate_withdrawals(conn):
    print("Generating withdrawals...")
    curs = conn.cursor()
    for i in generation_func.creators_dict.keys():
        for _ in range(random.randint(0, 10)):
            generate(curs, i)
    conn.commit()
    curs.close()
    print("Withdrawals successfully generated.")
