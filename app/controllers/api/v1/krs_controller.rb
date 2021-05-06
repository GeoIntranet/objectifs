class Api::V1::KrsController < ApplicationController

  before_action :set_kr, only:[:update,:destroy]

  def process_weight
    krs = Kr.where(objectif_id:params[:objectif_id]).pluck(:weight)

    if krs.sum != 100
      data = {status: false ,msg:"Invalid total weigh"}
    else
      data = {status: true,msg:"valid total weight"}
    end

    render json: data
  end

  def update
    respond_to do |format|
      data = Krs::Update.call(@kr,kr_params)
      format.json { render json: data }
    end
  end

  def destroy
    respond_to do |format|
      data = Krs::Delete.call(@kr)
      format.json { render json: data }
    end
  end


  def create
    respond_to do |format|
      data = Krs::Create.call(params[:objectif_id])
      format.json {render json: data }
    end
  end

  private

  def set_kr
    @kr = Kr.find(params[:id])
  end

  def kr_params
    params[:kr].permit(:title, :weight)
  end
end
