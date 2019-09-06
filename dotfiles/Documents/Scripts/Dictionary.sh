#!/bin/bash

clear
query=$1

result="$(sdcv -c -n -u 'Merriam-Webster Collegiate® Dictionary' ${query}|html2text --ignore-emphasis)"


parsedresult="${result//\\-->/\\n}\\n\\n"
parsedresult="${parsedresult//---|---/  }"
parsedresult="${parsedresult//Dictionary/  }"
parsedresult="${parsedresult//Merriam-Webster Collegiate®/Merriam-Webster Collegiate® Dictionary}"
parsedresult="${parsedresult//Found 1 items, similar to test./  }"

parsedresult="${parsedresult//1 items, similar to ${query}./}"

parsedresult="${parsedresult//
1 /\\n1.)  }"
parsedresult="${parsedresult//
2 /\\n\\n2.)  }"
parsedresult="${parsedresult//
3 /\\n\\n3.)  }"
parsedresult="${parsedresult//
4 /\\n\\n4.)  }"
parsedresult="${parsedresult//
5 /\\n\\n5.)  }"
parsedresult="${parsedresult//
6 /\\n\\n6.)  }"
parsedresult="${parsedresult//
7 /\\n\\n7.)  }"
parsedresult="${parsedresult//
8 /\\n\\n8.)  }"
parsedresult="${parsedresult//
9 /\\n\\n9.)  }"
parsedresult="${parsedresult//
10 /\\n\\n10.)  }"
#parsedresult="${parsedresult// : /\\n}"
parsedresult="${parsedresult//  : /  }"
parsedresult="${parsedresult//Found /  }"

#parsedresult="${parsedresult//  a : /\\n\\n - }"
parsedresult="${parsedresult//  a : /\\n - }"

parsedresult="${parsedresult//a (1) /\\n A  (1) }"
parsedresult="${parsedresult//b (1) /\\n - (1) }"
parsedresult="${parsedresult//c (1) /\\n - (1) }"
parsedresult="${parsedresult//d (1) /\\n - (1) }"

#parsedresult="${parsedresult//(1) /\\n  (1) }"
parsedresult="${parsedresult//(2)/\\n - (2)}"
parsedresult="${parsedresult//(3)/\\n - (3)}"
parsedresult="${parsedresult//(4)/\\n - (4)}"
parsedresult="${parsedresult//(5)/\\n - (5)}"
parsedresult="${parsedresult//(6)/\\n - (6)}"
parsedresult="${parsedresult//(7)/\\n - (7)}"
parsedresult="${parsedresult//(8)/\\n - (8)}"
parsedresult="${parsedresult//(9)/\\n - (9)}"
parsedresult="${parsedresult//(10)/\\n - (10)}"

parsedresult="${parsedresult// - (1) :/\\n -}"
parsedresult="${parsedresult// - (2) :/\\n -}"
parsedresult="${parsedresult// - (3) :/\\n -}"
parsedresult="${parsedresult// - (4) :/\\n -}"
parsedresult="${parsedresult// - (5) :/\\n -}"
parsedresult="${parsedresult// - (6) :/\\n -}"
parsedresult="${parsedresult// - (7) :/\\n -}"
parsedresult="${parsedresult// - (8) :/\\n -}"
parsedresult="${parsedresult// - (9) :/\\n -}"
parsedresult="${parsedresult// - (10) :/\\n -}"


printf "$parsedresult"
