#!/usr/bin/env python3

import sys

def read_until(chars):
    buffer = ""
    while True:
        c = sys.stdin.read(1)
        if not c:
            return buffer if len(buffer) > 0 else None
        buffer += c
        if c in chars:
            return buffer

def read():
    text = ""
    while True:
        r = read_until("()")
        if not r:
            return text
        text += r
        if text[-1] == "(":
            r = read()
            if not r:
                text = text[:-1]
            else:
                text += r
        elif text[-1] == ")":
            if "/usr/" in text:
                # print("Skipping: " + text)
                return None
            return text

while True:
    r = read()
    if not r:
        break
    else:
        r = "\n".join(filter(lambda x: len(x) > 0, r.splitlines()))
        print(r, end="")
