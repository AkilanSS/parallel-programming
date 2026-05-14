export void simple(uniform float vin[], uniform float vout[], uniform int count){
    
    foreach(index = 0 ... count)
    {
        float v = vin[index];
        if (v < 3)
            v = v * v;
        else
            v = sqrt(v);
        
        vout[index] = v;
    }
    
}

export void mandelbrot_set(uniform int result[1001][], uniform float a, uniform float b, uniform int subdivisions){
    
    foreach(i = 0 ... subdivisions + 1, j = 0 ... subdivisions + 1)
    {
        float z_re;
        float z_im;

        const float c_re = a + ((b - a) / subdivisions) * j;
        const float c_im = a + ((b - a) / subdivisions) * i;

        for(int k = 0; k < 256; i++)
        {
            if (sqrt(z_re * z_re + z_im * z_im) >= 10){
                result[i][j] = k;
                break;
            }

            const float z_re_new = z_re * z_re - z_im * z_im + c_re;
            const float z_im_new = 2 * z_re * z_im + c_im;

            z_re = z_re_new;
            z_im = z_im_new;
        }
    }
    
}