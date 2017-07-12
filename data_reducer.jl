using CSV
using DataFrames
using Baoab

new_nosteps = 1000
new_filename = "reduced.csv"

dist_df = CSV.read(string(Baoab.dir_loc, Baoab.filename))
nosteps = Int(nrow(dist_df))
freq = div(nosteps, new_nosteps)

new_df = dist_df[1, :]
CSV.write(string(Baoab.dir_loc, new_filename), new_df)

for p in [1:new_nosteps;]
  new_df = dist_df[p * freq, :]
  CSV.write(string(Baoab.dir_loc, new_filename), new_df, append=true)
end
