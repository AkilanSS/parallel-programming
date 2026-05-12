CXX = clang++
# IMPORTANT: -mavx2 is required for x86intrin.h to resolve correctly
CXXFLAGS = -std=c++20 -O1 -mavx2 -mavx512vl -Wall -stdlib=libc++

all: main

main: main.cpp
	$(CXX) $(CXXFLAGS) main.cpp -o main.exe
	$(CXX) $(CXXFLAGS) -S main.cpp 

clean:
	rm -f main