require 'json'
require 'open-uri'

class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    if params[:gh_nickname].present?
      @company.engineers
      redirect_to @company
    end
  end

end
