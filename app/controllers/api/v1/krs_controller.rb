class Api::V1::KrsController < ApplicationController

  before_action :set_kr, only:[:update,:destroy]

  def index
    Kr.all
  end

  def update
    respond_to do |format|
      if @kr.update(kr_params)
        data = {status: :ok,msg:"KR updated successfully",data:@kr}
      else
        data = {status: :error,msg:"Error",data:{}}
      end

      format.json { render json: data }
    end
  end

  def destroy
    respond_to do |format|
      if @kr.delete
        data = {status: :ok,msg:"KR deleted successfully"}
      else
        data = {status: :error,msg:"Error",data:{}}
      end

      format.json { render json: data }
    end
  end


  def create
    respond_to do |format|
      @kr = Kr.new({title:"placeholder",weight:0,objectif_id:params[:objectif_id]})

      if @kr.save

        data = {status: :ok,msg:"Kr created successfully",data:@kr}
      else
        data = {status: :error,msg:"Error KR creation",data:{}}
      end

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
