defmodule SampleNxOpenBlas do
  require Logger

  @moduledoc """
  Documentation for `SampleNxOpenBlas`.
  """

  @on_load :load_nif

  @doc false
  def load_nif do
    nif_file = ~c'#{Application.app_dir(:sample_nx_open_blas, "priv/libnif")}'

    case :erlang.load_nif(nif_file, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.error("Failed to load NIF: #{inspect(reason)}")
    end
  end

  def scopy_nif(_t), do: :erlang.nif_error(:not_loaded)
end
