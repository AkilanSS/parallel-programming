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

void clamped_exp_serial(float* values, int* exponents,  float* output, int N)
{
    for (int i = 0; i < N; i++)
    {
        float x = values[i];
        float y = exponents[i];

        if (y == 0)
        {
            output[i] = 1.0f;
        }
        else
        {
            float result = x;
            int count = y - 1;
            while (count > 0)
            {
                result = result * x;
                count--;
            }

            if (result > 9.99999f)
            {
                result = 9.99999f;
            }
            else 
            output[i] = result;
        }
    }
}


//Will be using 8 wide SIMD instructions (__m256)
void clamped_exp_vector(float* values, int* exponents, float* output, int N)
{
    __m256i zero = _mm256_set1_epi32(0);
    __m256i one = _mm256_set1_epi32(1);
    __m256 final_result;

    int i = 0;
    for (; i <= N - 8; N += 8)
    {
        __m256 x = _mm256_loadu_ps(&values[i]);
        __m256i y = _mm256_loadu_epi32(&exponents[i]);

        __mmask8 zero_mask = _mm256_cmpeq_epi32_mask(zero, y); // if (y == 0)
        

        __m256 result = x;
        __m256i count = _mm256_sub_epi32(y, one);

        __m256i count_gt_0_mask = _mm256_cmpgt_epi32(count, zero);

    }
}