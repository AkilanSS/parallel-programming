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

/**
* Fixed-length power. Take a vector of float and raise all to P.
* Serial implementation
*/
void fixed_power_serial(float* input, int P, float* output, int N)
{
    for (int i = 0; i < N; i++)
    {
        float x = input[i];
        float result = input[i];
        int count = P - 1;
        while (count > 0)
        {
            result *= x;
            count--;
        }
        output[i] = result;
    }
}

/**
* Fixed-length power. Take a vector of float and raise all to P.
* Vector implementation
*/
void fixed_power_vector(float* input, int P, float* output, int N)
{
    __m256 one = _mm256_set1_ps(1.f);
    __m256 zero = _mm256_setzero_ps();

    int i = 0;
    for (; i <= N - 8; i += 8)
    {
        __m256 x = _mm256_loadu_ps(&input[i]);
        __m256 result = _mm256_loadu_ps(&input[i]);
        int count = P - 1;

        while (count > 0)
        {
            result = _mm256_mul_ps(result, x);
            count--;
        }

        _mm256_storeu_ps(&output[i], result);
    }
}

/**
* Serial version of clampedExp(). If v^e > 9.99, 9.999 else v^e
*/
void clampedExp_serial(float* values, int* exponents, float* output, int N)
{
    for (int i = 0; i < N; i++)
    {
        float x = values[i];
        float res = 1;
        int exp = exponents[i];

        while (exp > 0)
        {
            res = res * x;
            exp--;
        }
        if (res > 9.9999f)
        {
            res = 9.9999f;
        }
        output[i] = res;
    }
}

/** 
* Vector implementation of clampedExp()
*/
void clampedExp_vector(float* values, int* exponents, float* output, int N)
{
    /**
    * TODO:
    * - Load a wide variable of 8 sp base in a variable. This will be the inital result register.
    * - Load a wide variable of 8 32i exponenets in a variable. Subtract one from this.
    * - Compute the mask of exponent register greater than 0. Eg: 11100101.
    * - Compute the mask of result register greater than 9.9999f. Eg 0001001.
    * - Compute the one step multiplication, and update the result register based on the first and second mask.
    * - Decrement the exponent register
    * - Repeat
    * - Store the result
    * -
    * -
    * - Alternatively. Compute the full exponentiation. Compute mask of result greater than 9.999f. Store with the mask (Might save some cycles)
    */

    __m256 clamp_val = _mm256_set1_ps(9.9999f);

    int i = 0;
    for (;i <= N - 8; i += 8)
    {
        __m256 x = _mm256_loadu_ps(&values[i]);
        __m256 res = _mm256_set1_ps(1.f);
        __m256i exp = _mm256_loadu_epi32(&exponents[i]);

        __m256i exp_gt_zero_mask = _mm256_cmpgt_epi32(exp, _mm256_setzero_si256());
        while (!_mm256_testz_si256(exp_gt_zero_mask, exp_gt_zero_mask)) //This instruction compresses the mask to just 8 bits. 
        {                                                                    // if 00000000 which is 0, then all exp are less than or equal to zero, so we can stop
            __m256 res_t = _mm256_mul_ps(res, x);
            res = _mm256_blendv_ps(res, res_t, _mm256_castsi256_ps(exp_gt_zero_mask));
            exp = _mm256_sub_epi32(exp, _mm256_set1_epi32(1));
            exp_gt_zero_mask = _mm256_cmpgt_epi32(exp, _mm256_setzero_si256()); //Update mask
        }

        __m256 clamp_mask = _mm256_cmp_ps(res, clamp_val, 0x0E);
        res = _mm256_blendv_ps(res, clamp_val, clamp_mask);

        _mm256_storeu_ps(&output[i], res);
    }
}

int main()
{ 
    constexpr int N = 8; //comptime babyyyy
    float input[N] = {3.f, 4.f, 5.f, 1.f, 4.f, 9.f, 2.f, 1.f};
    int exp[N] = {1, 4, 1, 4, 1, 6, 1, 3};
    float output[N];

    clampedExp_serial(input, exp, output, N);

    for (int i = 0; i < N; i++)
    {
        cout << output[i] << " ";
    }

    cout << endl;

    clampedExp_vector(input, exp, output, N);

    for (int i = 0; i < N; i++)
    {
        cout << output[i] << " ";
    }

    cout << endl;

}