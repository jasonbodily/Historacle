class ExplorerController < ApplicationController
  before_filter :authenticate_user!
  layout "explorer"

  def index
    @chronicles = current_user.library.chronicles
    render 'index'
  end

end
