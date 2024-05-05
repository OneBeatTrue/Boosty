def generate_attachment_types(conn):
    print("Generating attachment types...")
    curs = conn.cursor()
    curs.execute("""
        INSERT INTO attachment_types (attachment_type)
        VALUES (%s)
    """, ("Photo",))
    # conn.commit()
    curs.execute("""
        INSERT INTO attachment_types (attachment_type)
        VALUES (%s)
    """, ("Video",))
    # conn.commit()
    curs.execute("""
        INSERT INTO attachment_types (attachment_type)
        VALUES (%s)
    """, ("File",))
    # conn.commit()
    curs.execute("""
        INSERT INTO attachment_types (attachment_type)
        VALUES (%s)
    """, ("Audio",))
    conn.commit()
    curs.close()
    print("Attachment types successfully generated.")
