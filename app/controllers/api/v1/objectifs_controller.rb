class Api::V1::ObjectifsController < ApplicationController

  before_action :set_objectif, only:[:update,:destroy]

  def index
    render json: Objectifs::List.call
  end

  def update
    respond_to do |format|
      data = Objectifs::Update.call(@objectif,objectif_params)
      format.json { render json: data }
    end
  end

  def destroy
    respond_to do |format|
      data = Objectifs::Delete.call(@objectif)
      format.json { render json: data }
    end
  end


  def create
    respond_to do |format|
      data = Objectifs::Create.call
      format.json {render json: data }
    end
  end

  private

  def set_objectif
    @objectif = Objectif.find(params[:id])
  end

  def objectif_params
    params[:objectif].permit(:title, :weight)
  end

end
