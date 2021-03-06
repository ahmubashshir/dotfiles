#!/bin/env python3
import yaml
import requests as r
from sys import argv, exit
from subprocess import call
try:
    with open("maps.yml") as file:
        maps = yaml.load(file, Loader=yaml.FullLoader)
except FileNotFoundError:
    print("maps.yml doesn't exist.")
    exit(1)
for ep in maps["eps"].keys():
    try:
        data = r.get(maps["api"].format(**maps["eps"][ep]))
    except Exception:
        continue
    if data.ok:
        json = data.json()
        src = None
        name = maps["name"].format(**locals())
        for n in ["source", "source_bk"]:
            if n in json.keys():
                src = next(k["file"] for k in json[n])
                break
        if src:
            print(f"Downloading {name}")
            call(['wget', '-cO', name, src])
