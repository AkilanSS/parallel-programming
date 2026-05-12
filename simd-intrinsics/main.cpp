#pragma GCC target("avx2")
#pragma GCC optimize("O1")

#include <x86intrin.h>
#include <xmmintrin.h>
#include <iostream>
#include <vector>
#include <chrono>

using namespace std;

//Implement clampedExp()
// if a^b > 9.9999 => 9.9999, else a^b

void clamped_relu_serial(float* input, float* output, int N)
{
    for (int i = 0; i < N; i++)
    {
        float x = input[i];
        if (x < 0)
        {
            output[i] = 0;
        }
        else
        {
            output[i] = 1;
        }
    }
} 

//8-wide SIMD
void clamped_relu_vector(float* input, float* output, int N)
{
    _mm256_zeroall(); //clears all contents in simd registers (found this when i did ctrl + space)

    __m256 zero = _mm256_setzero_ps();
    __m256 one = _mm256_set1_ps(1.f);

    //implement min(max(x, 0), 1)
    int i = 0;
    for(; i <= N - 8; i++)
    {
        __m256 x = _mm256_load_ps(&input[i]);
        __m256 max_x_0 = _mm256_max_ps(x, zero);
        __m256 min_max = _mm256_min_ps(max_x_0, one);
        
        _mm256_store_ps(&output[i], min_max);
    }
} 

int main()
{ 
    constexpr int N = 8; //comptime babyyyy
    float input[N] = {-3, 4, -5, 1, 4, -9, 2, 1};
    float output[N];

    clamped_relu_serial(input, output, N);

    for (int i = 0; i < N; i++)
    {
        cout << output[i] << " ";
    }

    cout << endl;

    clamped_relu_vector(input, output, N);

    for (int i = 0; i < N; i++)
    {
        cout << output[i] << " ";
    }

    cout << endl;

}