defmodule SampleNxOpenBlas.System do
  def system() do
    %{
      os: os(),
      package_system: package_system(),
      open_blas: open_blas(),
      open_blas_include: open_blas_include(),
      open_blas_lib: open_blas_lib(),
      lib_openblas: lib_openblas()
    }
  end

  def os() do
    {_, name} = :os.type()
    os_s(name)
  end

  defp os_s(:darwin), do: :macOS
  defp os_s(:nt), do: :Windows
  defp os_s(:freebsd), do: :FreeBSD
  defp os_s(_), do: :Linux

  def package_system() do
    package_system_s(os())
  end

  defp package_system_s(:Windows), do: :none

  defp package_system_s(:FreeBSD), do: :none

  defp package_system_s(:macOS) do
    case System.find_executable("brew") do
      nil -> :none
      _ -> :homebrew
    end
  end

  defp package_system_s(:Linux) do
    release =
      Path.wildcard("/etc/*release*")
      |> Enum.map(&File.read!/1)
      |> Enum.flat_map(&String.split(&1, "\n"))

    case package_system_linux(release) do
      :aptitude -> :aptitude
      false -> :none
    end
  end

  defp package_system_linux(release) do
    release
    |> Enum.filter(&String.match?(&1, ~r/^ID(_LIKE)?=debian$/))
    |> Enum.count()
    |> case do
      0 -> false
      _ -> :aptitude
    end
  end

  def open_blas() do
    case open_blas_include() do
      "" -> false
      _ -> true
    end
  end

  def open_blas_include() do
    open_blas_include_s(package_system())
  end

  defp open_blas_include_s(:homebrew) do
    "#{open_blas_path(:homebrew)}/include"
  end

  defp open_blas_include_s(:aptitude) do
    open_blas_path(:aptitude)
    |> Enum.filter(&String.match?(&1, ~r|include.*openblas(64-pthread)?$|))
    |> case do
      [] -> ""
      list -> hd(list)
    end
  end

  def open_blas_lib() do
    open_blas_lib_s(package_system())
  end

  defp open_blas_lib_s(:homebrew) do
    "#{open_blas_path(:homebrew)}/lib"
  end

  defp open_blas_lib_s(:aptitude) do
    open_blas_path(:aptitude)
    |> Enum.filter(&String.match?(&1, ~r|lib.*openblas(64-pthread)?$|))
    |> case do
      [] -> ""
      list -> hd(list)
    end
  end

  def lib_openblas() do
    Path.wildcard("#{open_blas_lib()}/libopenblas*.{so,dylib}")
    |> case do
      [] ->
        ""

      list ->
        hd(list) |> basename() |> String.slice(3..-1)
    end
  end

  defp basename(path) do
    if String.match?(path, ~r/\./) do
      ext = Path.extname(path)
      Path.basename(path, ext) |> basename()
    else
      path
    end
  end

  defp open_blas_path(:homebrew) do
    {result, 0} = System.cmd("brew", ["--prefix", "openblas"], stderr_to_stdout: true)

    result
    |> String.trim()
  end

  defp open_blas_path(:aptitude) do
    case System.cmd("dpkg", ["-L", "libopenblas64-pthread-dev"], stderr_to_stdout: true) do
      {result, 0} ->
        String.split(result, "\n")

      {_, 1} ->
        case System.cmd("dpkg", ["-L", "libopenblas-dev"], stderr_to_stdout: true) do
          {result, 0} -> String.split(result, "\n")
          {_, 1} -> []
        end
    end
  end
end
