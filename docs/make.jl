using Latexify
using Documenter
using ModelingToolkit
using KinematicChains

makedocs(
    sitename="KinematicChains",
    format=Documenter.HTML(),
    modules=[KinematicChains],
    pages=[
        "Overview" => [
            "Getting Started" => "index.md",
            "Docstrings" => "docstrings.md"
        ],
        "Models" => [

        ]
    ]
)

deploydocs(
    target="build",
    repo="github.com/cadojo/KinematicChains.jl.git",
    branch="gh-pages",
    devbranch="main",
    versions=["stable" => "v^", "manual", "v#.#", "v#.#.#"],
)
