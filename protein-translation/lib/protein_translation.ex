defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna), do: do_of_rna(rna |> chunk_by(3), [])

  # Source: https://stackoverflow.com/a/43062280/468556
  defp chunk_by(string, n) do
    string
    |> Stream.unfold(&String.split_at(&1, n))
    |> Enum.take_while(&(&1 != ""))
  end

  defp do_of_rna([], result), do: {:ok, result |> Enum.reverse()}

  defp do_of_rna([codon | tail], result) do
    case of_codon(codon) do
      {:ok, "STOP"} -> {:ok, result |> Enum.reverse()}
      {:ok, amino} -> do_of_rna(tail, [amino | result])
      _ -> {:error, "invalid RNA"}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon("AUG"), do: {:ok, "Methionine"}
  def of_codon("UGG"), do: {:ok, "Tryptophan"}
  def of_codon(codon) when codon in ~W(UUU UUC), do: {:ok, "Phenylalanine"}
  def of_codon(codon) when codon in ~W(UUA UUG), do: {:ok, "Leucine"}
  def of_codon(codon) when codon in ~W(UCU UCC UCA UCG), do: {:ok, "Serine"}
  def of_codon(codon) when codon in ~W(UAU UAC), do: {:ok, "Tyrosine"}
  def of_codon(codon) when codon in ~W(UGU UGC), do: {:ok, "Cysteine"}
  def of_codon(codon) when codon in ~W(UAA UAG UGA), do: {:ok, "STOP"}
  def of_codon(_invalid), do: {:error, "invalid codon"}
end
