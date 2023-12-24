defmodule Dummy.MixProject do
  use Mix.Project

  def project do
    [
      app: :dummy,
      version: "2.0.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/strangemachines/dummy",
      homepage_url: "https://hexdocs.pm/dummy",
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test,
        "coveralls.lcov": :test
      ],
      docs: [
        main: "Dummy",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14", only: :test},
      {:meck, "~> 0.8"}
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
      licenses: ["MPL-2.0"],
      links: %{"GitHub" => "https://github.com/strangemachines/dummy"}
    ]
  end
end
