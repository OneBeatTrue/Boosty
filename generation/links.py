import random

import generation_func


def generate(curs, creator_id):
    curs.execute("""
        INSERT INTO links (creator_id, link)
        VALUES (%s, %s);
    """, (creator_id, generation_func.generate_string()))


def generate_links(conn):
    print("Generating links...")
    curs = conn.cursor()
    for i in generation_func.creators_dict.keys():
        for _ in range(random.randint(0, 10)):
            generate(curs, i)
    conn.commit()
    curs.close()
    print("Links successfully generated.")
