defmodule LoraTranciever.MixProject do
  use Mix.Project

  def project do
    [
      app: :lora_tranciever,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :dev,
      deps: deps(),
	  atomvm: [
	  start: LoraTranciever,
	  flash_offset: 0x210000
	  ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :lora_sender]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
	  {:exatomvm, git: "https://github.com/atomvm/ExAtomVM/"},
    {:atomvm_lib, git: "https://github.com/atomvm/atomvm_lib.git"},
    {:mqtt_client, git: "https://github.com/atomvm/atomvm_mqtt_client.git"},
    {:erl2ex, ">= 0.0.9", git: "https://github.com/dazuma/erl2ex.git", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
