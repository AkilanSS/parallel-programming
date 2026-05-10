#%%
import matplotlib.pyplot as plt
import matplotlib.text as txt

x = [1,2,3,4,5,6,7,8,12,16,32,64,128,255]
y = [149.218, 77.942, 131.177, 72.974, 95.498, 68.850, 75.378, 57.926, 45.324, 38.684, 27.692, 24.212, 30.221, 43.996]

#%%
plt.plot(x, y)
plt.savefig("./mandelbrot_set/scripts/render.png")

plt.close()
plt.figure(figsize= (10, 5))
plt.title("Execution Speedup")
plt.xlabel("Number of threads")
plt.ylabel("Speedup multiplier (from single thread)")
plt.plot(x, list(map(lambda t: y[0]/t, y)))
plt.plot(64, 149.218/24.212, 'r*', ms=10)
plt.text(x = 64, y = 5.8, s="64 threads, 6.1x performance", size = 'x-large', weight = 'bold')
plt.grid(True)
plt.savefig("./mandelbrot_set/scripts/execution-speedup.png")