import json
import itertools

with open("_data.json") as f:
    rows = json.load(f)

def get_category(o):
    return o["category"]

for category, items in itertools.groupby(sorted(rows, key=get_category), get_category):
    print(f'\n# {category}')
    for l in items:
        print(f'* [{l["language"]}]({l["link"]}){l.get("link_extra", "")}: [{l["file"]}](https://github.com/jaredkrinke/100-languages/blob/main/src/{l["file"]}) ([notes]({l["notes"]}))')
