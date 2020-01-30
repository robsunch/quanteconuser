``` this is a julia source file, and random stuff

using InstantiateFromURL
github_project("QuantEcon/quantecon-notebooks-julia", version = "0.4.0")

x = 2

using Plots
function snapabove(g, a)
  function f(x)
    if x > a     # "a" is captured in the closure f
      return g(x)
    else
      return g(a)
    end
  end
  return f  # closure with the embedded a
end

f(x) = x^2
h = snapabove(f, 2.0)

gr(fmt=:png);
plot(h, 0.0:0.1:5.0)

for i in 1:3
    print(i)
end
x_values = 1:5

for x = x_values
  println(x*x)
end

[ i + j for i in 1:3, j in 4:6 ]
function foo(x)
    if x > 0
        return "positive"
    end
    return "nonpositive"
end

x_vec = [0.0 2.0 3.0 4.0]
y_vec = sin.(x_vec)

using LinearAlgebra, Statistics


function chisq(k)
  @assert k > 0
  z = randn(k)
  return sum(z -> z^2, z)
end

y = chisq.([2 4 6])

f(x, y) = [1, 2, 3] ⋅ x + y   # "⋅" can be typed by \cdot<tab>
f([3, 4, 5], 2)   # uses vector as first parameter
f.(Ref([3, 4, 5]), [2, 3])

twice(f,x) = f(f(x))
f(x) = x^2
@show twice(f, 2.0)

twice(x -> x^2, 2.0)

a = 5
g(x) = a * x
twice(g,2.0)

using Expectations, Distributions
@show d = Exponential(2.0)
f(x) = x^2
@show expectation(f, d);  # E(f(x))

function multiplyit(a, g)
    return x -> a * g(x)  # function with `g` used in the closure
end
f(x) = x^2
h = multiplyit(2.0, f)    # use our quadratic, returns a new function which doubles the result
h(2)     #

a = zeros(2,2)
println(a)
x = Array{Float64}(undef, 2, 2)
println(x)
x[1,1] = 1;
println(x)

a = [1 2; 3 4]
a[:, 2] = [4 5]

a[:,2] = [3;3]
println(a)

a = [1 2; 3 4]
b = a' # transpose
c = Matrix(b)  # convert to matrix
d = collect(b)
a = [0,1,-1]
b = sort(a, rev=false)
println(b)
println(a)

a = zeros(1,3,4);
b = dropdims(a,dims = 1)

using Parameters
function f(parameters)
    @unpack α, β = parameters # poor style, error prone if adding parameters
    return α + β
end
parameters = (α = 0.1, γ = "test", β = 0.2)
f(parameters)

function f(x)
  if x > 0
    return x
  else
    return NaN
  end
end

using Base: show_supertypes
show_supertypes(Int32)
@show subtypes(Int32)

struct Foo
    a::Float64
    b::Int64
    c::Vector{Float64}
end
foo_nt = FooNotTyped(2.0, 3, [1.0, 2.0, 3.0])
typeof(foo_nt)

f(x) = x
x_iv = [1.0]
#f(x) = 1.1 * x # fixed-point blows

# BAD!
xstar = fixedpoint(f, x_iv).zero # assumes convergence
xsol = nlsolve(f, x_iv).zero # assumes convergence

# GOOD!
result = fixedpoint(f, x_iv)
converged(result) || error("Failed to converge in $(result.iterations) iterations")
xstar = result.zero

f(x) = 1.1 * x

result = nlsolve(f, x_iv)
converged(result) || error("Failed to converge in $(result.iterations) iterations")
xsol = result.zero

using LinearAlgebra, Statistics
using QuantEcon, QuadGK, FastGaussQuadrature, Distributions, Expectations
using Interpolations, Plots, LaTeXStrings, ProgressMeter

li = LinearInterpolation(x, y)
li_spline = CubicSplineInterpolation(x, y)

@show li(0.3) # evaluate at a single point

scatter(x, y, label = "sampled data", markersize = 4)
plot!(xf, li.(xf), label = "linear")
plot!(xf, li_spline.(xf), label = "spline")

f(x) = x > 0.0 ? x : nothing
@code_warntype f(1)

function f(a, b)
    y = (a + 8b)^2
    return 7y
end

@code_native f(1.0,2.0)
