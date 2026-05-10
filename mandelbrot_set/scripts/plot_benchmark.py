#%%
import matplotlib.pyplot as plt
import matplotlib.text as txt

x = [1,2,3,4,5,6,7,8,12,16,32,64,128,255]
y = [140.068, 76.910, 49.342, 39.836, 32.187, 26.412, 23.479, 23.473, 19.308, 18.344, 19.845, 19.434, 23.785, 37.232]
speedup = list(map(lambda t: y[0]/t, y))

for i in range(len(x)) :
    print(f"- Time to compute with {x[i]} threads: {y[i]}ms ({speedup[i]:.3f})")




#%%
plt.plot(x, y)
plt.savefig("./mandelbrot_set/scripts/render.png")

plt.close()
plt.figure(figsize= (10, 5))
plt.title("Execution Speedup (Interleaved)")
plt.xlabel("Number of threads")
plt.ylabel("Speedup multiplier (from single thread)")
plt.plot(x, list(map(lambda t: y[0]/t, y)))
plt.plot(16, 140.068/18.344, 'r*', ms=10)
plt.text(x = 16, y = 7, s="16 threads, 7.6xx performance", size = 'x-large', weight = 'bold')
plt.grid(True)
plt.savefig("./mandelbrot_set/scripts/execution-speedup-interleaved.png")