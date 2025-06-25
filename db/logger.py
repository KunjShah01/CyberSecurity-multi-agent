import sqlite3
from datetime import datetime
import os
import json

def log_to_db(scan_id, query, result):
    os.makedirs("database", exist_ok=True)
    conn = sqlite3.connect("database/logs.db")
    cursor = conn.cursor()

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS logs (
            id TEXT PRIMARY KEY,
            query TEXT,
            status TEXT,
            timestamp TEXT,
            threatintel TEXT,
            osint TEXT,
            correlation TEXT,
            rag TEXT,
            report TEXT,
            selftest TEXT,
            alert TEXT
        )
    """)

    cursor.execute("""
        INSERT INTO logs (id, query, status, timestamp, threatintel, osint, correlation, rag, report, selftest, alert)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, (
        scan_id,
        query,
        "complete" if result["selftest"].get("status") == "PASSED" else "issue",
        datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        json.dumps(result.get("threatintel")),
        json.dumps(result.get("osint")),
        json.dumps(result.get("correlation")),
        json.dumps(result.get("rag")),
        json.dumps(result.get("report")),
        json.dumps(result.get("selftest")),
        json.dumps(result.get("alert"))
    ))

    conn.commit()
    conn.close()

def read_logs():
    conn = sqlite3.connect("database/logs.db")
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM logs ORDER BY timestamp DESC")
    rows = cursor.fetchall()
    columns = [col[0] for col in cursor.description]
    conn.close()

    return [dict(zip(columns, row)) for row in rows]
