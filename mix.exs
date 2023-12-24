defmodule Dummy.MixProject do
  use Mix.Project

  def project do
    [
      app: :dummy,
      version: "1.0.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:meck, "~> 0.8.13"}
    ]
  end

  defp description do
    "Elixir mocking that makes sense. Dummy relies on meck and exposes a
      simpler way to mock methods than mock"
  end

  defp package do
    [
      name: :dummy,
      files: ~w(mix.exs lib .formatter.exs README.md LICENSE),
      maintainers: ["nomorepanic"],
      licenses: ["MPL 2.0"],
      links: %{"GitHub" => "https://github.com/Vesuvium/dummy"}
    ]
  end
end
