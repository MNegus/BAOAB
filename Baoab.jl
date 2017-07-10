# baoab-limit.jl
module Baoab

using Distributions
using DataFrames
using CSV
using Potentials

function __init__()
  global N = 1000 # Particle number
  global nbins = 1000 # Number of bins
  global δt = 0.15 # Timestep
  global NO_TIMESTEPS = 10000 # Number of timesteps
  global M = 1 # Mass of particles
  global kT = 1 # Boltzmann constant * Temperature

  global x_min = -6 # Minimum value of x
  global x_max = 6 # Maximum value of x

  global bin_width = (x_max - x_min) / nbins # Width of bins

  global bar_pos = [x_min + j * bin_width for j in [0:(nbins-1);]]

  global x_L = -2 # Position of left minimum
end

export N, nbins, δt, NO_TIMESTEPS, M, kT, x_min, x_max, bin_width, bar_pos, x_L


# Returns the x-position of a given bin
function bin_pos(bin_no)
  return x_min + (bin_no - 1) * bin_width
end

# Returns the bin number that a given x value lies in
function bin_no(x)
  for j in [1:nbins;]
    if (x >= bin_pos(j)) && (x < bin_pos(j + 1))
      return j
    end
  end
  return 1
end

function simulate()
  # Initial distribution of particles
  init_dist = Normal(-2, 0.5)
  x_pos = rand(init_dist, N)

  X = [bin_no(x) for x in x_pos]'
  X_next = zeros(Float64, N)'
  R = randn(N)
  R_next = randn(N)

  df = convert(DataFrame, X)
  CSV.write("/home/michael/Documents/URSS 2017/Julia files/baob_limit/particle_dist.csv", df)


  for m in [1:NO_TIMESTEPS;]
    for j in [1:N;]
      x = bin_pos(X[j]) # x position of particle j
      x_next = x - (δt * Potentials.DΦ(x)) / M + sqrt((kT * δt) / (2 * M)) * (R[j] + R_next[j])
      X_next[j] = bin_no(x_next)
    end
    R = R_next
    R_next = randn(N)
    X = X_next
    df = convert(DataFrame, X)
    CSV.write("/home/michael/Documents/URSS 2017/Julia files/baob_limit/particle_dist.csv", df, append=true)
  end
end



end
