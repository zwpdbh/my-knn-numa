CC=gcc
FLAGS= -O2 -g -W -fopenmp 
LDFLAGS=-lflann -lgsl -lgslcblas -lrbc

all: csv_parser.o sdc_index.o main.o rbc_index.o
	$(CC) $(FLAGS) $(LDFLAGS) csv_parser.o sdc_index.o main.o rbc_index.o -o main

csv_parser.o: csv_parser.cpp csv_parser.h
	$(CC) $(FLAGS) $(INCLUDE) -c csv_parser.cpp

rbc_index.o: rbc_index.cpp rbc_index.h common.h
	$(CC) $(FLAGS) $(INCLUDE) -c rbc_index.cpp

sdc_index.o: sdc_index.cpp sdc_index.h common.h
	$(CC) $(FLAGS) $(INCLUDE) -c sdc_index.cpp

main.o: main.cpp main.h common.h flann_kdtree_index.h flann_kmeans_index.h flann_linear_index.h
	$(CC) $(FLAGS) $(INCLUDE) -c main.cpp

clean:
	rm -f *.o
	rm -f main
