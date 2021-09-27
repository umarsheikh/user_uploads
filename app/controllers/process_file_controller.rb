class ProcessFileController < ApplicationController
  def index
  end

  def import
    if request.get?
    else
      @users = User.import(params[:file])
    end
  end
end
