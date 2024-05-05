import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import generation_func


def generate(curs):
    curs.execute("""
        INSERT INTO users (name, phone_number, email, profile_picture, password)
        VALUES (%s, %s, %s, %s, %s)
    """, (generation_func.generate_name(), generation_func.generate_phone_number(), generation_func.generate_email(), generation_func.generate_bytea(), generation_func.generate_password()))


def generate_users(conn, n):
    print("Generating users...")
    curs = conn.cursor()
    for _ in range(n):
        generate(curs)
    conn.commit()
    curs.close()
    print("Tags successfully generated.")

