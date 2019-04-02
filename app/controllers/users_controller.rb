class UsersController < ApplicationController

  skip_before_action :authenticate_request

  def create
    call CreateUser, params
  end

  def login
    call AuthenticateUser, params
  end
end