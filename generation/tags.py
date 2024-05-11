import random

import generation_func


def generate(curs, post_id, hashtag):
    curs.execute("""
        INSERT INTO tags (tag, post_id)
        VALUES (%s, %s);
    """, (hashtag, post_id))


def generate_tags(conn):
    print("Generating tags...")
    curs = conn.cursor()
    for i in range(generation_func.posts_amount):
        if random.randint(0, 1):
            tags = set()
            for _ in range(3):
                tags.add(generation_func.generate_tag())
            for tag in tags:
                generate(curs, i + 1, tag)
    conn.commit()
    curs.close()
    print("Tags successfully generated.")

