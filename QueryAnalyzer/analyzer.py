import psycopg2
import os
import time


class QueryPerformanceAnalyzer:
    def __init__(self, queries_file, query_tries=3):
        self.queries_file = queries_file
        self.query_tries = query_tries
        self.results = []
        self.queries = []

    def load_queries(self):
        with open(self.queries_file, 'r') as file:
            queries_str = file.read()
            self.queries = queries_str.split(';')

    def analyze_queries(self):
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
            total_time = 0
            best_time = float('inf')
            worst_time = 0
            cost = 0
            for i in range(self.query_tries):
                start_time = time.time()

                cursor.execute(f"EXPLAIN ANALYZE {query}")
                result = cursor.fetchall()

                cost = float(next((x.split('=')[1].split()[0].split('..')[1] for x in result[0] if 'cost=' in x), '0'))
                elapsed_time = time.time() - start_time
                total_time += elapsed_time
                if elapsed_time < best_time:
                    best_time = elapsed_time
                if elapsed_time > worst_time:
                    worst_time = elapsed_time


                print(f"Query: {query.strip()}, Attempt: {i + 1}, Cost: {cost}, Elapsed Time: {elapsed_time} seconds")

            avg_time = total_time / self.query_tries
            self.results.append({
                'query': query.strip(),
                'cost': cost,
                'best_time': best_time,
                'avg_time': avg_time,
                'worst_time': worst_time
            })

        cursor.close()
        conn.close()

    def write_results(self):
        number = 1
        filename = os.path.join(os.path.dirname(os.path.abspath(__file__)), f"performance/query_performance_results_{number}.txt")
        while os.path.exists(filename):
            number += 1
            filename = os.path.join(os.path.dirname(os.path.abspath(__file__)), f"performance/query_performance_results_{number}.txt")
        with open(filename, 'w') as file:
            for result in self.results:
                file.write(f"query: {result['query']}\n")
                file.write(f"cost: {result['cost']}\n")
                file.write(f"best_time: {result['best_time']}\n")
                file.write(f"avg_time: {result['avg_time']}\n")
                file.write(f"worst_time: {result['worst_time']}\n\n")


if __name__ == "__main__":
    queries_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "queries.sql")
    query_tries = int(os.environ.get("QUERY_TRIES"))

    analyzer = QueryPerformanceAnalyzer(queries_file, query_tries)
    analyzer.load_queries()
    analyzer.analyze_queries()
    analyzer.write_results()
