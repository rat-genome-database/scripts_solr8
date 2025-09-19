import sys
import re
import json

def clean_text(text):
    if not isinstance(text, str):
        return text

    replacements = {
        "\u00B2": "2",   # ²
        "\u00B3": "3",   # ³
        "\u2070": "0",
        "\u00B9": "1",
        "\u2071": "i",
        "\u2074": "4",
        "\u2075": "5",
        "\u2076": "6",
        "\u2077": "7",
        "\u2078": "8",
        "\u2079": "9",
        "\u207A": "+",   # ⁺
        "\u207B": "-",   # ⁻
        "\u207C": "=",   # ⁼
        "\u207D": "(",   # ⁽
        "\u207E": ")",   # ⁾
        "\u2080": "0",   # ₀
        "\u2081": "1",
        "\u2082": "2",
        "\u2083": "3",
        "\u2084": "4",
        "\u2085": "5",
        "\u2086": "6",
        "\u2087": "7",
        "\u2088": "8",
        "\u2089": "9",
        "\u208A": "+",
        "\u208B": "-",
        "\u208C": "=",
        "\u00B7": ".",   # Middle dot
        "\u2212": "-",   # Unicode minus
        "\u2013": "-",   # En dash
        "\u2014": "-",   # Em dash
        "\u201C": '"',
        "\u201D": '"',
        "\u2018": "'",
        "\u2019": "'",
        "\u2028": " ",   # Line separator
        "\u2029": " "    # Paragraph separator
    }

    for old, new in replacements.items():
        text = text.replace(old, new)

    # Remove other control characters
    text = re.sub(r'\s+', ' ', text)
    return text.strip()

def clean_json_line(line, data_source):
    try:
        obj = json.loads(line)

        # Convert p_date to Solr date-time format and add p_source
        if "p_date" in obj:
            date_val = obj["p_date"][0]
            if len(date_val) == 10:  # Format: yyyy-mm-dd
                obj["p_date"][0] = date_val + "T06:00:00Z"

        obj["p_source"] = [data_source]

        # Clean all string fields
        for key, value in obj.items():
            if isinstance(value, list):
                obj[key] = [clean_text(v) if isinstance(v, str) else v for v in value]
            elif isinstance(value, str):
                obj[key] = clean_text(value)

        return obj
    except Exception as e:
        print(f"Error parsing line:\n{line}\nError: {e}", file=sys.stderr)
        return None

# === Main Script ===
if len(sys.argv) < 3:
    print("Usage: python script.py <input_file> <p_source_value>")
    sys.exit(1)

input_file = sys.argv[1]
data_source = sys.argv[2]
cleaned_docs = []

with open(input_file, encoding='utf-8') as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        cleaned_obj = clean_json_line(line, data_source)
        if cleaned_obj:
            cleaned_docs.append(cleaned_obj)

# Output valid JSON array
print(json.dumps(cleaned_docs, indent=2, ensure_ascii=False))

