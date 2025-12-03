class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]
  def show
    @event = current_user.created_events
  end
end
