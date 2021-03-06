defmodule Opc.Mixfile do
  use Mix.Project

  def project do
    [app: :fadex,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package()
   ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE*"],
      maintainers: ["lschuermann"],
      links: %{"GitHub" => "https://github.com/lschuermann/fadex"},
      licenses: ["Apache 2.0"],
      description: "Implements the OpenPixelControl-Protocol (for use with fadecandy)"
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
  [
    {:ex_doc, ">= 0.0.0", only: :dev}
  ]
  end
end
