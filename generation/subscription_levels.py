import random
import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import generation_func


def generate(curs, creator_id):
    curs.execute("""
        INSERT INTO subscription_levels (creator_id, price, title, cover, description, welcome_message)
        VALUES (%s, %s, %s, %s, %s, %s);
    """, (creator_id, generation_func.generate_money(), generation_func.generate_string(), generation_func.generate_bytea(), generation_func.generate_string(), generation_func.generate_string()))
    generation_func.sub_levels_amount += 1


def generate_subscription_levels(conn):
    print("Generating subscription levels...")
    curs = conn.cursor()
    for i in generation_func.creators_dict.keys():
        for _ in range(random.randint(1, 5)):
            generate(curs, i)
            generation_func.creators_dict[i].add(generation_func.sub_levels_amount)
    conn.commit()
    curs.close()
    print("Subscription levels successfully generated.")
