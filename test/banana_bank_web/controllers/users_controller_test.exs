defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

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
  end
end
