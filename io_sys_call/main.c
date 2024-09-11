#include <stdio.h>

extern int _puts(int count, char* str);
extern int _gets(int count, char* str);
extern int _atoi(char* str);
extern int _itoa(int value, char* str);

int main() {
    char text[] = "Banana!\n";

    _puts(9, text);
    int got = _gets(9, text);
    _puts(got, text);

    char number[] = "1232";
    // char number[] = "123456789101112";
    int value = _atoi(number);

    printf("Value: %d\n", value);

    int written = _itoa(value, number);
    printf("Written: %d; Number: %s\n", written, number);
    _puts(written, number);

    return 0;
}