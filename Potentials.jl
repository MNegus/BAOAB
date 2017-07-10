module Potentials

# External potential function
function Φ(x)
  if x <= -1
    return 5 * (x + 2)^2
  elseif x <= 1.2
    return 10 - 5*x^2
  else
    return 5 * (x - 2.4)^2 - 4.4
  end
end

# Derivative of potential function
function DΦ(x)
  if x <= -1
    return 10 * (x + 2)
  elseif x <= 1.2
    return -10 * x
  else
    return 10 * (x - 2.4)
  end
end

end
