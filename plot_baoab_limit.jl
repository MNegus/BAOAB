using PyPlot
using Potentials
using DataFrames
using CSV
using Baoab

# Function for potential (purely for visualisation)
x_range = linspace(Baoab.x_min, Baoab.x_max, 1000)
potential_range = [Potentials.Φ(p) for p in x_range]
plot(x_range, potential_range)

dist_df = CSV.read("/home/michael/Documents/URSS 2017/Julia files/baob_limit/particle_dist.csv")

initial_bar_heights = zeros(Int64, Baoab.nbins)
final_bar_heights = zeros(Int64, Baoab.nbins)

for p in [1:ncol(dist_df);]
  initial_bar_heights[Int(get(dist_df[1,p]))] += 1
  final_bar_heights[Int(get(dist_df[nrow(dist_df),p]))] += 1
end
b = bar(Baoab.bar_pos, initial_bar_heights, 0.01, color="blue")
b = bar(Baoab.bar_pos, final_bar_heights, 0.01, color="red")
