using Baoab
using PyPlot
using Distributions


init_dist = Normal(-2, 0.5)
x_pos = rand(init_dist, Baoab.N)
X = [Baoab.bin_no(x) for x in x_pos]
R = randn(N)
R_next = randn(N)

x = -2.2
j = Baoab.bin_no(x)
x_next = x - (δt * Potentials.DΦ(x)) / m + sqrt((kT * δt) / (2 * M)) * (R[j] + R_next[j])
println(x_next)

# bar_heights = zeros(Int64, Baoab.nbins)
# for p in X
#   bar_heights[p] += 1
# end
#
# p = indmax(bar_heights)
# println(Baoab.bin_pos(p))
#
#
# b = bar(Baoab.bar_pos, bar_heights, 0.01, color="blue")
