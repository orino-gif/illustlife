class AgreesController < ApplicationController
  def show
    @agree = params[:id]
  end
end
