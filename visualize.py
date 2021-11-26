#!/usr/bin/env python3

import json
import pathlib

data_files = pathlib.Path('data/').glob('*.json')

for data_file in data_files:
    data_type, data_version = data_file.stem.split('-', 1)
    data = json.loads(data_file.read_text())
    for dist, report in data.items():
        if not report['repo_only'] and not report['git_only']:
            color = 'green'
        else:
            color = 'red'
        print(f'<div style="background-color: {color}">')
        print(f'<h2>{data_type} - {data_version} - {dist}</h2>')
        print('<h3>only in repo</h3>')
        print('<ul>')
        for entry in report['repo_only']:
            print(f'<li>{entry}</li>')
        print('</ul>')
        print('<h3>only in git</h3>')
        print('<ul>')
        for entry in report['git_only']:
            print(f'<li>{entry}</li>')
        print('</ul>')
        print('</div>')
