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

    char number[] = "12345";
    char writtenNumber[] = "000000";
    // char number[] = "123456789101112";
    int value = _atoi(number);

    printf("Value: %d\n", value);

    int written = _itoa(value, writtenNumber);
    printf("Written: %d; Number: %s\n", written, writtenNumber);
    _puts(written, writtenNumber);

    char number2[100];
    int value2 = 4321;
    int written2 = _itoa(value2, number2);
    printf("\nWritten: %d; Number: %s\n", written2, number2);
    _puts(written2, number2);

    return 0;
}