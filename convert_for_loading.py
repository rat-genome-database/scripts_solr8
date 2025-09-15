import sys
import re

print("[")

with open(sys.argv[1]) as f:
	lines = f.readlines()

for line in lines:
        line = re.sub(r'("p_date":\["\d{4}-\d{2}-\d{2})"', '\\1T06:00:00Z"],"p_source":["preprint"', line)
        print(line);
        print(",")

print("]")


