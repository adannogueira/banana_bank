defmodule BananaBank.Users do
  alias BananaBank.Users.Update
  alias BananaBank.Users.Create
  alias BananaBank.Users.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
end
