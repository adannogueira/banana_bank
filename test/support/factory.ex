defmodule ExMachinaFactory do
  use ExMachina.Ecto, repo: BananaBank.Repo

  alias BananaBank.Users.User

  def user_factory do
    %User{
      name:     "Test User",
      cep:      "12345678",
      email:    "test@user.com",
      password_hash: "123456"
    }
  end
end
