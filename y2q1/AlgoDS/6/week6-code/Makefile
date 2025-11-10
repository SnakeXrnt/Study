program: main.c functions.c
	gcc -o program main.c functions.c

main.c: functions.c
	cp functions.c main.cp

functions.c: main.c
	cp main.c functions.c
