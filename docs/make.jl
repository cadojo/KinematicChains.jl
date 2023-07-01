using Latexify
using Documenter
using ModelingToolkit
using ManipulatorKinematics

makedocs(
    sitename="ManipulatorKinematics",
    format=Documenter.HTML(),
    modules=[ManipulatorKinematics],
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
    repo="github.com/cadojo/ManipulatorKinematics.jl.git",
    branch="gh-pages",
    devbranch="main",
    versions=["stable" => "v^", "manual", "v#.#", "v#.#.#"],
)
