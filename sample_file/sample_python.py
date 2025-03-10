# Python サンプル

import json
import csv

# 外部ファイルの読み込み
with open('sample_external/config.json') as f:
    config = json.load(f)
print(f"Config setting1: {config['setting1']}")

# クラス定義
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def greet(self):
        print(f"Hello, my name is {self.name} and I am {self.age} years old.")

# ループ処理
people = [Person("Alice", 30), Person("Bob", 25)]
for person in people:
    person.greet()
