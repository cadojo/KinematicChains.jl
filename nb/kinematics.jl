### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 3d2a38d1-cde5-4e83-a105-47e0eda9189e
begin

	import Pkg
	Pkg.activate(".")
	using CommonLicenses: MIT
	using ModelingToolkit
	using ManipulatorKinematics
	
end;

# ╔═╡ ab3be940-18f0-11ee-39f8-db3200927f2c
md"""
# 🦾 Manipulator Kinematics
"""

# ╔═╡ 0a621aa0-3635-4437-bbcd-dc690c6cb215
MIT(copyright="Joe(y) Carpinelli")

# ╔═╡ 2b528814-4c02-41e5-952b-0756cd410e57
md"""
$$\text{position}(T_0^1 T_1^2 T_2^3) = p = \begin{bmatrix} x \\ y \\ z \end{bmatrix}$$
"""

# ╔═╡ 695c008d-2a97-4c20-800a-d418f6072574
 @variables J[1:3,1:3]; collect(J)

# ╔═╡ e4e98623-d7d3-4757-9252-d1a208319703
# ẋ = J * θ̇

# ╔═╡ c0078bdb-cc20-4a05-a408-f1a5134f6c39
# θ̇ = inv(J) * ẋ

# ╔═╡ 2fb00da1-6a93-4b29-abdf-8542abfa0591
begin
	Z = [
		1 0 0
		0 1 0
		0 0 1
	]

	inv(Z)
end

# ╔═╡ 21a7e4e4-e76b-43cd-bc97-f98d1185ad24
function ik(position_desired, guess_angles; tolerance = 1e-8)

	xd = positition_desired

	θg = guess_angles
	xg = fk(θg)

	if max(abs(xd - xg)) < tolerance
		return θg
	end

	error = xd - xg
	Jg = jacobian(θg)
	
	dθ = inv(Jg) * error
	θg = θg + dθ
	
	return ik(position_desired, θg)
	
end

# ╔═╡ 2d27adf3-a497-4613-ad0b-1db88d0fd6e6
md"""
## Dependencies
"""

# ╔═╡ Cell order:
# ╟─ab3be940-18f0-11ee-39f8-db3200927f2c
# ╟─0a621aa0-3635-4437-bbcd-dc690c6cb215
# ╠═2b528814-4c02-41e5-952b-0756cd410e57
# ╠═695c008d-2a97-4c20-800a-d418f6072574
# ╠═e4e98623-d7d3-4757-9252-d1a208319703
# ╠═c0078bdb-cc20-4a05-a408-f1a5134f6c39
# ╠═2fb00da1-6a93-4b29-abdf-8542abfa0591
# ╠═21a7e4e4-e76b-43cd-bc97-f98d1185ad24
# ╟─2d27adf3-a497-4613-ad0b-1db88d0fd6e6
# ╠═3d2a38d1-cde5-4e83-a105-47e0eda9189e
