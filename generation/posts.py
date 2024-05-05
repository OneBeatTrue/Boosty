import random

import generation_func


def generate(curs, creator_id, minimal_required_sub_level_id):
    curs.execute("""
        INSERT INTO posts (creator_id, minimal_required_sub_level_id, title, content, teaser_text, teaser_img, comments_availability)
        VALUES (%s, %s, %s, %s, %s, %s, %s);
    """, (creator_id, minimal_required_sub_level_id, generation_func.generate_string(), generation_func.generate_text(), generation_func.generate_string(), generation_func.generate_bytea(), "true"))
    generation_func.posts_amount += 1


def generate_posts(conn):
    print("Generating posts...")
    curs = conn.cursor()
    for i in generation_func.creators_dict.keys():
        for j in generation_func.creators_dict[i]:
            for _ in range(random.randint(0, 3)):
                generate(curs, i, j)
    conn.commit()
    curs.close()
    print("Posts successfully generated.")
