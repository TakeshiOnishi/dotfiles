// JavaScript サンプル

const fs = require('fs');

// 外部ファイルの読み込み
const config = JSON.parse(fs.readFileSync('sample_external/config.json', 'utf-8'));
console.log(`Config setting1: ${config.setting1}`);

// クラス定義
class Person {
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }

    greet() {
        console.log(`Hello, my name is ${this.name} and I am ${this.age} years old.`);
    }
}

// ループ処理
const people = [new Person("Alice", 30), new Person("Bob", 25)];
people.forEach(person => person.greet());
