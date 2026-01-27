#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define DATA_SIZE 65535

int main(int argc, char *argv[]) {
    FILE *in, *out;
    int c, last = 0, count = 0;

    if (argc != 2) {
        fprintf(stderr, "Usage: %s program.bf\n", argv[0]);
        return 1;
    }

    in = fopen(argv[1], "r");
    if (!in) {
        perror("fopen input");
        return 1;
    }

    out = fopen("out.c", "w");
    if (!out) {
        perror("fopen output");
        fclose(in);
        return 1;
    }

    /* Emit C program */
    fprintf(out,
        "#include <stdio.h>\n"
        "#include <stdint.h>\n\n"
        "int main(void) {\n"
        "    uint8_t data[%d] = {0};\n"
        "    unsigned int ptr = 0;\n",
        DATA_SIZE
    );

    while ((c = fgetc(in)) != EOF) {
        if (c == last && (c == '+' || c == '-' || c == '>' || c == '<')) {
            count++;
            continue;
        }

        if (count > 0) {
            switch (last) {
                case '+': fprintf(out, "    data[ptr] += %d;\n", count); break;
                case '-': fprintf(out, "    data[ptr] -= %d;\n", count); break;
                case '>': fprintf(out, "    ptr += %d;\n", count); break;
                case '<': fprintf(out, "    ptr -= %d;\n", count); break;
            }
            count = 0;
        }

        switch (c) {
            case '+': case '-': case '>': case '<':
                last = c;
                count = 1;
                break;
            case '.':
                fprintf(out, "    putchar(data[ptr]);\n");
                fprintf(out, "    fflush(stdout);\n"); // Forces character to show in terminal
                break;
            case ',':
                fprintf(out, "    data[ptr] = getchar();\n");
                break;
            case '[':
                fprintf(out, "    while (data[ptr]) {\n");
                break;
            case ']':
                fprintf(out, "    }\n");
                break;
            default:
                break;
        }

        if (c != '+' && c != '-' && c != '>' && c != '<') {
            last = 0;
        }
    }

    if (count > 0) {
        switch (last) {
            case '+': fprintf(out, "    data[ptr] += %d;\n", count); break;
            case '-': fprintf(out, "    data[ptr] -= %d;\n", count); break;
            case '>': fprintf(out, "    ptr += %d;\n", count); break;
            case '<': fprintf(out, "    ptr -= %d;\n", count); break;
        }
    }

    fprintf(out, "    return 0;\n}\n");

    fclose(in);
    fclose(out);

    /* Compile and run */
    if (system("gcc out.c -O2 -o hello") != 0) {
        fprintf(stderr, "Compilation failed\n");
        return 1;
    }

    system("./hello");

    /* Cleanup temporary files */
    remove("out.c");
    remove("hello");

    return 0;
}