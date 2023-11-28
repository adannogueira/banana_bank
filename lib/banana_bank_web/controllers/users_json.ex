defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created succesfully, welcome to BananaBank",
      data: user
    }
  end

  def get(%{user: user}), do: %{data: user}

  def update(%{user: user}), do: %{message: "User updated successfully", data: user}
end
