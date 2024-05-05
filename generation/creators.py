import random
import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import generation_func


def generate(curs, creator_id):
    curs.execute("""
        INSERT INTO creators (creator_id, cover, description, withdrawal_system_id, withdrawal_required_inf, balance)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (
        creator_id, generation_func.generate_bytea(), generation_func.generate_string(), random.randint(1, 3), generation_func.generate_string(),
        generation_func.generate_money()))


def generate_creators(conn, n):
    print("Generating creators...")
    curs = conn.cursor()
    for i in range(n):
        if random.randint(0, 1):
            generation_func.creators_dict[i + 1] = set()
            generate(curs, i + 1)
    conn.commit()
    curs.close()
    print("Creators successfully generated.")
