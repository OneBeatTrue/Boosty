import random

import generation_func


def generate(curs, post_id):
    curs.execute("""
        INSERT INTO attachments (attachment, post_id, attachment_type_id)
        VALUES (%s, %s, %s);
    """, (generation_func.generate_bytea(), post_id, random.randint(1, 4)))


def generate_attachments(conn):
    print("Generating attachments...")
    curs = conn.cursor()
    for i in range(generation_func.posts_amount):
        for _ in range(random.randint(1, 2)):
            generate(curs, i + 1)
    conn.commit()
    curs.close()
    print("Attachments successfully generated.")
