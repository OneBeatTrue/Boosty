def generate_bank_types(conn):
    print("Generating bank types...")
    curs = conn.cursor()
    curs.execute("""
        INSERT INTO bank_types (bank_type_name)
        VALUES (%s)
    """, ("Russian",))
    # conn.commit()
    curs.execute("""
        INSERT INTO bank_types (bank_type_name)
        VALUES (%s)
    """, ("Foreign",))
    conn.commit()
    curs.close()
    print("Bank types successfully generated.")
