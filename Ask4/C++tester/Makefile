all: create_random_image process_image file test

create_random_image: create_random_image.cpp 
	g++ -o create_random_image create_random_image.cpp

process_image: process_image.cpp
	g++ -o process_image process_image.cpp

file: file.cpp
	g++ -o file file.cpp

test : test.c
	gcc -o test test.c
