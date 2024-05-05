def generate_withdrawal_systems(conn):
    print("Generating withdrawal systems...")
    curs = conn.cursor()
    curs.execute("""
        INSERT INTO withdrawal_systems (name, percent, mandatory_deduction)
        VALUES (%s, %s, %s)
    """, ("Bank cards", "0.5", "30.0"))
    # conn.commit()
    curs.execute("""
        INSERT INTO withdrawal_systems (name, percent, mandatory_deduction)
        VALUES (%s, %s, %s)
    """, ("VK Pay", "0.0", "0.0"))
    # conn.commit()
    curs.execute("""
        INSERT INTO withdrawal_systems (name, percent, mandatory_deduction)
        VALUES (%s, %s, %s)
    """, ("PayPal", "2.5", "0.0"))
    conn.commit()
    curs.close()
    print("Withdrawal systems successfully generated.")
