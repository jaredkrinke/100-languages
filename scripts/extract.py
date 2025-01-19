import json
import re

def omit_empty(o):
    return {k: v for k, v in o.items() if v}

with open("README.md") as f:
    input = re.search(r"(\| 1 \|.*\|)", f.read(), re.DOTALL)[1]

pattern = r"^\| \d+ \| \[(?P<problem>.*?)\].*?\| \[(?P<language>.*?)\]\((?P<link>.*?\)?)\)(?P<link_extra>.*?) \| \[(?P<file>.*?)\]\(.*?\)(?P<file_extra>.*?) \|$"
data = [
    omit_empty({
        "problem": l["problem"],
        "language": l["language"],
        "category": "?",
        "link": l["link"],
        "link_extra": l["link_extra"],
        "file": l["file"],
        "file_extra": l["file_extra"],
    })
    for l in map(lambda s: re.match(pattern, s), input.split("\n"))
]

print(json.dumps(data, indent=2))
