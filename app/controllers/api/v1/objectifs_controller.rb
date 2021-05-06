class Api::V1::ObjectifsController < ApplicationController

  before_action :set_objectif, only:[:update,:destroy]

  def process_weight
    objectifs = Objectif.all.pluck(:weight)

    if objectifs.sum != 100
      data = {status: false ,msg:"Invalid total weigh"}
    else
      data = {status: true,msg:"valid total weight"}
    end

    render json: data
  end

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
