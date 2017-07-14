using Plots
using Potentials
using DataFrames
using CSV
using Baoab

nbins = 1000

# Function for potential (purely for visualisation)
x_range = linspace(-4, 4, 1000)
potential_range = [Potentials.Φ(p) for p in x_range]
equil_range = [exp(-Potentials.Φ(p)) for p in x_range]
plt = plot(x_range, potential_range)
plot!(x_range, equil_range, color="red")

filename = "freq_test.csv"

dist_df = CSV.read(string(Baoab.dir_loc, filename))

histogram!([get(dist_df[nrow(dist_df), p]) for p in 1:Baoab.N], bins=nbins)
savefig(string(Baoab.dir_loc, "plot.png"))
