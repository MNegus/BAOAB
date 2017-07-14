using Plots
using Potentials
using DataFrames
using Baoab
using CSV

nbins = 1000

# Function for potential (purely for visualisation)
x_range = linspace(-4, 4, 1000)
potential_range = [Potentials.Φ(p) for p in x_range]


filename = "output_1500000.csv"

dist_df = CSV.read(string(Baoab.dir_loc, filename))

anim = @animate for timestep in 1:nrow(dist_df)
  X = [get(dist_df[timestep, p]) for p in 1:Baoab.N]
  p = plot(x_range, potential_range)
  histogram!(X, bins=nbins)
end every 10
gif(anim, string(Baoab.dir_loc, "anim.gif"))
