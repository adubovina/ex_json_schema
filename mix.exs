defmodule ExJsonSchema.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_json_schema,
      version: "0.7.2",
      elixir: "~> 1.3",
      description:
        "A JSON Schema validator with full support for the draft 4 specification and zero dependencies.",
      deps: deps(),
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, dialyzer: :test],
      dialyzer: [
        plt_add_apps: [:ex_unit],
        plt_core_path: ".",
        plt_add_deps: :transitive
      ]
    ]
  end

  def application do
    [extra_applications: []]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8", only: :test},
      {:poison, "~> 1.5", only: :test},
      {:excoveralls, "~> 0.10", only: :test},
      {:mix_test_watch, "~> 0.2.6", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 0.5", only: [:test], runtime: false}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md LICENSE),
      maintainers: ["Jonas Schmidt"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/jonasschmidt/ex_json_schema"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
