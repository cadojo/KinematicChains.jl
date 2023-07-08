# `KinematicChains.jl`

_Kinematic models for serial and parallel robotic manipulators!_

## Overview

This package extends `ModelingToolkit` to represent robot manipulator kinematic
models. All available models are shown on the [Docstrings](docstrings.md) page.
Consult the **Models** pages for more detail about each model in this package!

## Usage

If you're familiar with [`ModelingToolkit.jl`](https://mtk.sciml.ai/dev/), then
you'll be able to use this package! Some `KinematicChains`-specific usage
instructions are provided here. Please don't be shy about making
[Discourse](https://discourse.julialang.org) posts, or filing
[issues](https://github.com/cadojo/KinematicChains.jl) on GitHub!

### Installation & Setup

This package can be installed just like any other
[registered](https://juliahub.com) Julia package.

```julia
# To install wherever Julia code runs...
import Pkg
Pkg.add("KinematicChains") # or ]add KinematicChains in Julia's REPL
```

To load the package, simply enter `using KinematicChains`.

```@repl main
using KinematicChains
```
