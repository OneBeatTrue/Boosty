import psycopg2
import os
import time


class Runner:
    def __init__(self, queries_file):
        self.queries_file = queries_file
        self.queries = []

    def load_queries(self):
        with open(self.queries_file, 'r') as file:
            queries_str = file.read()
            self.queries = queries_str.split(';')

    def run(self):
        attempts = 10
        for attempt in range(1, attempts + 1):
            try:
                conn = psycopg2.connect(
                    dbname=os.environ.get("POSTGRES_DB"),
                    user=os.environ.get("POSTGRES_USER"),
                    password=os.environ.get("POSTGRES_PASSWORD"),
                    host=os.environ.get("POSTGRES_HOST"),
                    port=os.environ.get("PORT")
                )
                print("Successfully connected to the database.")
                cursor = conn.cursor()
                break
            except psycopg2.OperationalError as e:
                print(f"Attempt {attempt}: Connection failed. Error: {e}")
                if attempt < attempts:
                    time.sleep(1)
                else:
                    print("All attempts failed. Exiting.")
                    exit(1)

        for query in self.queries:
            if query == "":
                continue
            query = ' '.join(query.split('\n'))
            cursor.execute(query)

        cursor.close()
        conn.close()


if __name__ == "__main__":
    queries_file = os.environ.get("FILE")
    runner = Runner(queries_file)
    runner.load_queries()
    runner.run()
