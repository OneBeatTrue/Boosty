import random

import generation_func


def generate(curs, post_id):
    curs.execute("""
        INSERT INTO tags (tag, post_id)
        VALUES (%s, %s);
    """, (generation_func.generate_string(), post_id))


def generate_tags(conn):
    print("Generating tags...")
    curs = conn.cursor()
    for i in range(generation_func.posts_amount):
        for _ in range(random.randint(0, 3)):
            generate(curs, i + 1)
    conn.commit()
    curs.close()
    print("Tags successfully generated.")

