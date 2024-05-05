import random

import generation_func

comments_amount = 0

def generate(curs, sender_id, comment, post):
    global comments_amount
    curs.execute("""
        INSERT INTO comments (recipient_comment_id, recipient_post_id, sender_id, message)
        VALUES (%s, %s, %s, %s);
    """, (comment, post, sender_id, generation_func.generate_text()))
    comments_amount += 1


def generate_comments(conn, n):
    print("Generating comments...")
    global comments_amount
    curs = conn.cursor()
    prev_comm = None
    prev_post = None
    for i in range(n):
        for _ in range(1, 3):
            post = None
            comment = None
            if random.randint(0, 1) or (not i) or (prev_comm is None) or (prev_post is None):
                post = random.randint(1, generation_func.posts_amount)
                generate(curs, i + 1, None, random.randint(1, generation_func.posts_amount))
            else:
                post = prev_post
                comment = prev_comm
                generate(curs, i + 1, comment, post)
            if random.randint(0, 1):
                prev_post = post
                prev_comm = comments_amount
    conn.commit()
    curs.close()
    print("Comments successfully generated.")
