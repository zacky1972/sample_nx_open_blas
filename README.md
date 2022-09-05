# SampleNxOpenBlas

Sample code of a bridge Nx to OpenBLAS.

## Benchmarks and results

You can run the benchmark by `mix run -r bench/blas_bench.exs`.
Then, you'll get similar to the following:

```
 % mix run -r bench/blas_bench.exs
make: Nothing to be done for `all'.
Operating System: macOS
CPU Information: Apple M2
Number of Available Cores: 8
Available memory: 24 GB
Elixir 1.14.0
Erlang 25.0.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: 1,000, 10,000, 100
Estimated total run time: 1.05 min

Benchmarking EXLA with input 1,000 ...

23:27:23.281 [warning] Failed to get CPU frequency: 0 Hz

23:27:23.284 [info] XLA service 0x126e05290 initialized for platform Host (this does not guarantee that XLA will be used). Devices:

23:27:23.284 [info]   StreamExecutor device (0): Host, Default Version
Benchmarking EXLA with input 10,000 ...
Benchmarking EXLA with input 100 ...
Benchmarking Nx with input 1,000 ...
Benchmarking Nx with input 10,000 ...
Benchmarking Nx with input 100 ...
Benchmarking OpenBLAS with input 1,000 ...
Benchmarking OpenBLAS with input 10,000 ...
Benchmarking OpenBLAS with input 100 ...

##### With input 1,000 #####
Name               ips        average  deviation         median         99th %
OpenBLAS     1568.85 K        0.64 μs  ±2438.31%        0.54 μs        5.25 μs
Nx             20.38 K       49.06 μs     ±4.02%       48.88 μs       54.29 μs
EXLA           17.27 K       57.90 μs    ±34.05%       55.83 μs      102.09 μs

Comparison: 
OpenBLAS     1568.85 K
Nx             20.38 K - 76.97x slower +48.42 μs
EXLA           17.27 K - 90.84x slower +57.27 μs

##### With input 10,000 #####
Name               ips        average  deviation         median         99th %
OpenBLAS      462.62 K        2.16 μs   ±529.47%        2.08 μs        2.71 μs
EXLA           16.56 K       60.37 μs    ±35.81%       56.42 μs      122.67 μs
Nx              2.05 K      486.71 μs     ±3.94%      483.92 μs      564.73 μs

Comparison: 
OpenBLAS      462.62 K
EXLA           16.56 K - 27.93x slower +58.21 μs
Nx              2.05 K - 225.16x slower +484.55 μs

##### With input 100 #####
Name               ips        average  deviation         median         99th %
OpenBLAS     2115.10 K        0.47 μs  ±3901.04%        0.42 μs        0.58 μs
Nx            180.50 K        5.54 μs    ±29.95%        5.29 μs       10.83 μs
EXLA           17.48 K       57.22 μs    ±20.46%       55.13 μs      102.04 μs

Comparison: 
OpenBLAS     2115.10 K
Nx            180.50 K - 11.72x slower +5.07 μs
EXLA           17.48 K - 121.03x slower +56.75 μs
```

## License

Copyright (c) 2022 University of Kitakyushu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
