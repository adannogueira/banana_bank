defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:name, :password, :email, :cep]

  @derive {Jason.Encoder, only: [:id, :name, :email, :cep]}
  schema "users" do
    field :name,          :string
    field :password,      :string, virtual: true
    field :password_hash, :string
    field :email,         :string
    field :cep,           :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> perform_validation(@required_params)
    |> add_password_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_params)
    |> perform_validation([:name, :email, :cep])
    |> add_password_hash()
  end

  defp perform_validation(user, required_params) do
    user
    |> validate_required(required_params)
    |> unique_constraint(:email, name: "email_unique_index")
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)
  end

  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Argon2.hash_pwd_salt(password))
  end

  defp add_password_hash(changeset), do: changeset
end
