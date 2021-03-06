defmodule MedApiWeb.Schema do
  use Absinthe.Schema

  alias MedApiWeb.Resolvers
  # import types
  import_types(MedApiWeb.Schema.Types)

  # queres
  query do
    @desc "Get a list of all users"
    field :users, list_of(:user_type) do
      resolve(&Resolvers.UserResolver.users/3)
    end
  end

  # mutations
  mutation do
    @desc "Register a new user"
    field :register_user, type: :user_type do
      # expect user to insert data of type :user_input_type which is defined in user_type.ex
      arg(:input, non_null(:user_input_type))
      resolve(&Resolvers.UserResolver.register_user/3)
    end

    @desc "Login a user and return a JWT token"
    field :login_user, type: :session_type do
      arg(:input, non_null(:session_input_type))
      resolve(&Resolvers.SessionResolver.login_user/3)
    end
  end
end
