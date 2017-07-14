# baoab-limit.jl
module Baoab

using Distributions
using DataFrames
using CSV
using Potentials

function __init__()
  global N = 1000 # Particle number
  global δt = 0.15 # Timestep
  global NO_TIMESTEPS = 1500000 # Number of timesteps
  global OUTPUT_FREQ = 1000 # Number of timesteps between each output
  global M = 1 # Mass of particles
  global kT = 1 # Boltzmann constant * Temperature

  global x_min = -6 # Minimum value of x
  global x_max = 6 # Maximum value of x

  global x_L = -2 # Position of left minimum

  global dir_loc = "/home/michael/Documents/URSS 2017/Julia files/baoab_limit/"

  global filename = "output_1500000.csv"
end

export N, δt, NO_TIMESTEPS, M, kT, x_min, x_max, x_L

function simulate(start_filename="")
  if start_filename == ""
    # Initial distribution of particles
    init_dist = Normal(x_L, 0.5)
    X = rand(init_dist, N)'
  else
    init_df = CSV.read(string(dir_loc, start_filename))
    X = [get(init_df[nrow(init_df), p]) for p in 1:N]'
  end

  X_next = zeros(Float64, N)'
  R = randn(N)
  R_next = randn(N)

  df = convert(DataFrame, X)
  CSV.write(string(dir_loc, filename), df)

  for m in [1:NO_TIMESTEPS;]
    for j in [1:N;]
      X_next[j] = X[j] - (δt * Potentials.DΦ(X[j])) / M + sqrt((kT * δt) / (2 * M)) * (R[j] + R_next[j])
    end
    R = R_next
    R_next = randn(N)
    X = X_next
    if m % OUTPUT_FREQ == 0
      df = convert(DataFrame, X)
      CSV.write(string(dir_loc, filename), df, append=true)
    end
  end
end

end
