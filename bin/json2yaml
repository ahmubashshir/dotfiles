#!/usr/bin/env python3
import sys
import json
import yaml
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('json_file', nargs='?', type=argparse.FileType('r'), default=sys.stdin)

json_file = parser.parse_args().json_file
json_body = json.loads(json_file.read())
yaml_body = yaml.dump(json_body, default_flow_style=False)
print(yaml_body, end='')

