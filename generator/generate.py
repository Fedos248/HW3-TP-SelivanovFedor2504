import csv
import random
import os
import sys

NUM_ROWS = 100


COLUMNS = ["page_count", "price", "copies_sold", "genre"]

def generate_row():

    return {
        "page_count": random.randint(50, 1000),
        "price": round(random.uniform(2.99, 99.99), 2),
        "copies_sold": random.randint(0, 5000),
        "genre": random.choice(["Fiction", "Non-Fiction", "Sci-Fi", "Mystery", "Biography"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)
