
from collections import Counter
import re

def top_3_words(text):
    c = Counter(re.findall(r"[a-z']+", re.sub(r" '+ ", " ", text.lower())))
    return [w for w,_ in c.most_common(150)]

with open('script.txt', "r", encoding="utf8") as f:
    text = top_3_words(f.read())

with open('wordList.txt', "w", encoding="utf8") as f:
    for el in text:
        if len(el)>2:
            f.write(el
                    +"\n")
            print(el)
        


