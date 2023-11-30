defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  alias BananaBank.Users
  alias Users.User

  describe "create/2" do
    test "creates user successfully", %{conn: conn} do
      params = %{name: "Test User", cep: "12345678", email: "test@user.com", password: "123456"}
      response = conn
      |> post(~p"/api/users", params)
      |> json_response(:created)

      assert  %{
        "data" => %{"cep" => "12345678", "email" => "test@user.com", "id" => _id, "name" => "Test User"},
        "message" => "User created succesfully, welcome to BananaBank"
      } = response
    end

    test "returns an error when invalid parameters are informed", %{conn: conn} do
      params = %{name: nil, cep: "1", email: "invalid", password: "123456"}
      response = conn
      |> post(~p"/api/users", params)
      |> json_response(:bad_request)

      assert  %{"errors" => %{
        "cep" => ["should be 8 character(s)"],
        "email" => ["has invalid format"],
        "name" => ["can't be blank"]
      }} = response
    end
  end

  describe "delete/2" do
    test "deletes user successfully", %{conn: conn} do
      params = %{name: "Test User", cep: "12345678", email: "test@user.com", password: "123456"}
      {:ok, %User{id: id}} = Users.create(params)
      response = conn
      |> delete(~p"/api/users/#{id}")
      |> json_response(:ok)

      assert  %{
        "data" => %{"cep" => "12345678", "email" => "test@user.com", "id" => id, "name" => "Test User"}
      } = response
    end

    test "returns an error when user does not exist", %{conn: conn} do
      response = conn
      |> delete(~p"/api/users/999")
      |> json_response(:not_found)

      assert  %{
        "message" => "User not found", "status" => "not_found"
      } = response
    end
  end
end
