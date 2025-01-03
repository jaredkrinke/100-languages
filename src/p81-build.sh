#!/bin/sh

rm p81.c
echo "(prescheme-compiler 'p81 '(\"p81-packages.scm\") 'p81-init \"p81.c\")\n,exit-when-done" | ~/scheme48/bin/scheme48 -i ps-compiler.image && gcc -I../c -L../c -o p81 p81.c ../c/libscheme48.a && time ./p81 0081_matrix.txt

