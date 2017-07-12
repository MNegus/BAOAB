using Plots
using Potentials
using DataFrames
using Baoab

# Function for potential (purely for visualisation)
x_range = linspace(Baoab.x_min, Baoab.x_max, 1000)
potential_range = [Potentials.Φ(p) for p in x_range]


filename = "reduced.csv"

dist_df = CSV.read(string(Baoab.dir_loc, filename))

anim = @animate for timestep in 1:nrow(dist_df)
  X = [Baoab.bin_pos(get(dist_df[timestep, p])) for p in 1:Baoab.N]
  p = plot(x_range, potential_range)
  histogram!(X, bins=Baoab.nbins)
end every 10
gif(anim, string(Baoab.dir_loc, "anim.gif"))
