import sys
import re

if len(sys.argv) < 3:
    print("Usage: python script.py <input_file> <p_source_value>")
    sys.exit(1)
data_source = sys.argv[2]
print("[")

with open(sys.argv[1]) as f:
	lines = f.readlines()

for line in lines:
        #line = re.sub(r'("p_date":\["\d{4}-\d{2}-\d{2})"', '\\1T06:00:00Z"],"p_source":["pubmed"', line)
        line = re.sub( r'("p_date":\["\d{4}-\d{2}-\d{2})"',r'\1T06:00:00Z"],"p_source":["' + data_source + '"',line)
        print(line);
        print(",")

print("]")


