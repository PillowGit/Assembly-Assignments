
# Script by Esteban Escartin

rm *.o
rm *.out

nasm -f elf64 -l trip.lis -o trip.o trip.asm

g++ -c -m64 -Wall -o source.o source.cpp -fno-pie -no-pie -std=c++17

g++ -m64 -o trip.out source.o trip.o -fno-pie -no-pie -std=c++17

./trip.out
