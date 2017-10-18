defmodule Firestorm.ForumsTest do
  use Firestorm.DataCase

  alias Firestorm.Forums

  describe "users" do
    alias Firestorm.Forums.User

    @valid_attrs %{email: "some email", name: "some name", username: "some username"}
    @update_attrs %{email: "some updated email", name: "some updated name", username: "some updated username"}
    @invalid_attrs %{email: nil, name: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Forums.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Forums.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Forums.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Forums.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forums.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Forums.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Forums.update_user(user, @invalid_attrs)
      assert user == Forums.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Forums.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Forums.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Forums.change_user(user)
    end
  end

  describe "categories" do
    alias Firestorm.Forums.Category

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Forums.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Forums.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Forums.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Forums.create_category(@valid_attrs)
      assert category.title == "some title"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forums.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, category} = Forums.update_category(category, @update_attrs)
      assert %Category{} = category
      assert category.title == "some updated title"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Forums.update_category(category, @invalid_attrs)
      assert category == Forums.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Forums.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Forums.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Forums.change_category(category)
    end
  end
end
