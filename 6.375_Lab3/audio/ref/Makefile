
all: pitch

pitch: pitch.c
	gcc -ggdb -o $@ $^ -lfftw3 -lm

fftw: fftw.cpp
	g++ -ggdb -o $@ $^ -lfftw3 -lm

clean:
	rm pitch fftw

