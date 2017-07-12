using Plots

x = linspace(0, 10, 1000)
p = plot(x, sin(x))
bar!([2, 4, 6], [0, 0, 0])
p[2] = [2, 4, 6], [0.1, 0.5, 0.2]
display(p)
