import random
import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import generation_func


def generate(curs, user_id, creator_id):
    curs.execute("""
        INSERT INTO followings (user_id, creator_id)
        VALUES (%s, %s);
    """, (user_id, creator_id))


def generate_followings(conn, n):
    print("Generating followings...")
    curs = conn.cursor()
    for i in range(n):
        creators = set([random.randint(1, n) for _ in range(random.randint(0, 15))])
        for j in creators:
            if j in generation_func.creators_dict.keys():
                generate(curs, i + 1, j)
    conn.commit()
    curs.close()
    print("Followings successfully generated.")
