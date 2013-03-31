class ExplorerController < ApplicationController

  layout "viewer"

  def index
    @chronicles = current_user.library.chronicles
  end

  def index2
  end

  def index3

  end

end
