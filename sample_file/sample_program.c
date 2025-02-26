#include <stdio.h>
#include <stdlib.h>

// C サンプルプログラム

// 構造体定義
typedef struct {
    char name[50];
    int age;
} Person;

// 関数定義
void greet(Person p) {
    printf("Hello, my name is %s and I am %d years old.\n", p.name, p.age);
}

int main() {
    // ループ処理
    Person people[] = {{"Alice", 30}, {"Bob", 25}};
    for (int i = 0; i < 2; i++) {
        greet(people[i]);
    }
    return 0;
}
