#pragma GCC target("avx2")
#pragma GCC target("avx512vl")
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

/**
 * Vectorized clamped ReLu function. Returns 0 when input less than 0, and 1 otherwise
 * @note
 * Here we implement a branchless way (unlike the serial implementation). Used 4 instructions for every 8 single-precision numbers
 */
void clamped_relu_vector(float* input, float* output, int N)
{
    _mm256_zeroall(); //clears all contents in simd registers (found this when i did ctrl + space)

    __m256 zero = _mm256_setzero_ps();
    __m256 one = _mm256_set1_ps(1.f);

    //implement min(max(x, 0), 1)
    int i = 0;
    for(; i <= N - 8; i+=8)
    {
        __m256 x = _mm256_load_ps(&input[i]);
        __m256 max_x_0 = _mm256_max_ps(x, zero);
        __m256 min_max = _mm256_min_ps(max_x_0, one);
        
        _mm256_store_ps(&output[i], min_max);
    }
} 


/**
* Serial implementation of fizzbuzz. If the number is even, multiplty by 2, else subtract 1
*/
void fizzbuzz_serial(int* input, int* output, int N)
{
    for(int i = 0; i < N; i++)
    {
        int x = input[i];
        if (x%2  == 0)
        {
            output[i] = 2 * x;
        }
        else
        {
            output[i] = x - 1;
        }
    }
}

/**
* Vectorized implementation of fizzbuzz. If the number is even, multiply by 2, else subtract 1  
*/
void fizzbuzz_vector(int* input, int* output, int N)
{
    /**
    * TODO: 
    * - Find the even and odd numbers are create a mask
    * - Compute the doubled vectors
    * - Compute the subtracted by 1 vectors
    * - Use blend with mask to double only even numbers
    * - Find the negation of the mask, and blend it to subtract only odd numbers
    */
    _mm256_zeroall();

    __m256i zero = _mm256_setzero_si256();
    __m256i one = _mm256_set1_epi32(1);
    __m128i one_128 = _mm_cvtsi32_si128(1); 

    int i = 0;
    for(; i <= N - 8; i+=8)
    {
        __m256i x = _mm256_loadu_epi32(&input[i]);
        __m256i odd_1 = _mm256_and_epi32(x, one); // x % 2
        __m256i odd_1_mask = _mm256_cmpeq_epi32(odd_1, zero); // generates mask for (x % 2 == 0)

        //__m256i doubled = _mm256_mullo_epi32(x, _mm256_set1_epi32(2)); // multiply by 1

        __m256i doubled = _mm256_sll_epi32(x, one_128); //shift left by 1
        __m256i sub_1 = _mm256_sub_epi32(x, one); // subtract by 1

        __m256i res_sub = _mm256_blendv_ps(sub_1, x, odd_1_mask);
        __m256i res_sub_doubled = _mm256_blendv_ps(res_sub, doubled, odd_1_mask);

        _mm256_storeu_epi32(&output[i], res_sub_doubled);
    }
}


int main()
{ 
    constexpr int N = 8; //comptime babyyyy
    int input[N] = {3, 4, 5, 1, 4, 9, 2, 1};
    int output[N];

    fizzbuzz_serial(input, output, N);

    for (int i = 0; i < N; i++)
    {
        cout << output[i] << " ";
    }

    cout << endl;

    fizzbuzz_vector(input, output, N);

    for (int i = 0; i < N; i++)
    {
        cout << output[i] << " ";
    }

    cout << endl;

}