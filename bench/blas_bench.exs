inputs = %{
  "100" => Nx.iota({100}, type: {:f, 32}),
  "1,000" => Nx.iota({1_000}, type: {:f, 32}),
  "10,000" => Nx.iota({10_000}, type: {:f, 32}),
}

host_jit = EXLA.jit(&Nx.multiply(2.0, &1))

Benchee.run(
  %{
    "Nx" => fn input -> Nx.multiply(2.0, input) end,
    "EXLA" => fn input -> host_jit.(input) end,
    "OpenBLAS" => fn input -> SampleNxOpenBlas.copy_scal_f32(2.0, input) end
  },
  inputs: inputs
)
