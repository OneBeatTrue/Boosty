import os
import time

import psycopg2
import generation.users as users
import generation.withdrawal_systems as withdrawal_systems
import generation.creators as creators
import generation.withdrawals as withdrawals
import generation.links as links
import generation.currencies as currencies
import generation.bank_types as bank_types
import generation.billings as billings
import generation.followings as followings
import generation.subscription_levels as subscription_levels
import generation.subscriptions as subscriptions
import generation.posts as posts
import generation.tags as tags
import generation.attachment_types as attachment_types
import generation.attachments as attachments
import generation.comments as comments


def main():
    n = int(os.environ.get("AMOUNT", "100"))
    attempts = 10
    for attempt in range(1, attempts + 1):
        try:
            conn = psycopg2.connect(
                dbname=os.environ.get("POSTGRES_DB"),
                user=os.environ.get("POSTGRES_USER"),
                password=os.environ.get("POSTGRES_PASSWORD"),
                host=os.environ.get("POSTGRES_HOST"),
                port=os.environ.get("EXTERNAL_PORT")
            )
            print("Successfully connected to the database.")
            break
        except psycopg2.OperationalError as e:
            print(f"Attempt {attempt}: Connection failed. Error: {e}")
            if attempt < attempts:
                time.sleep(1)
            else:
                print("All attempts failed. Exiting.")
                exit(1)

    print("Generation started")
    users.generate_users(conn, n)
    withdrawal_systems.generate_withdrawal_systems(conn)
    creators.generate_creators(conn, n)
    withdrawals.generate_withdrawals(conn)
    links.generate_links(conn)
    currencies.generate_currencies(conn)
    bank_types.generate_bank_types(conn)
    billings.generate_billings(conn, n)
    followings.generate_followings(conn, n)
    subscription_levels.generate_subscription_levels(conn)
    subscriptions.generate_subscriptions(conn, n)
    posts.generate_posts(conn)
    tags.generate_tags(conn)
    attachment_types.generate_attachment_types(conn)
    attachments.generate_attachments(conn)
    comments.generate_comments(conn, n)
    print("Generation finished")
    conn.close()


if __name__ == "__main__":
    main()
