def generate_currencies(conn):
    print("Generating currencies...")
    curs = conn.cursor()
    curs.execute("""
        INSERT INTO currencies (currency_name)
        VALUES (%s)
    """, ("Rubles",))
    # conn.commit()
    curs.execute("""
        INSERT INTO currencies (currency_name)
        VALUES (%s)
    """, ("Dollars",))
    # conn.commit()
    curs.execute("""
        INSERT INTO currencies (currency_name)
        VALUES (%s)
    """, ("Euro",))
    # conn.commit()
    curs.execute("""
        INSERT INTO currencies (currency_name)
        VALUES (%s)
    """, ("Yuan",))
    conn.commit()
    curs.close()
    print("Currencies successfully generated.")
