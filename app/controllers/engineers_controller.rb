class EngineersController < ApplicationController

  def index
    @engineers = Engineer.all
    @engineer = Engineer.new
  end

  def create
    @engineer = Engineer.new(engineer_params)
    if @engineer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def engineer_params
    params.require(:engineer).permit(:gh_nickname)
  end
end
