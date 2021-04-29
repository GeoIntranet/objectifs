class Api::V1::ObjectifsController < ApplicationController

  before_action :set_objectif, only:[:update,:destroy]

  def index
    json_data =  Objectif.includes(:krs).all.map do |objectif|
      objectif.as_json(include: :krs)
    end
    render json: json_data
  end

  def update
    respond_to do |format|
      if @objectif.update(objectif_params)
        data = {status: :ok,msg:"Objectif updated successfully",data:@objectif}
      else
        data = {status: :error,msg:"Error",data:{}}
      end

      format.json { render json: data }
    end
  end

  def destroy
    respond_to do |format|
      if @objectif.delete
        Kr.where(objectif_id:params[:id]).delete_all
        data = {status: :ok,msg:"Objectif deleted successfully"}
      else
        data = {status: :error,msg:"Error",data:{}}
      end

      format.json { render json: data }
    end
  end


  def create
    respond_to do |format|
      @objectif = Objectif.new({title:"placeholder",weight:0})
      if @objectif.save
        data = {status: :ok,msg:"Objectif created successfully",data:@objectif}
      else
        data = {status: :error,msg:"Error",data:{}}
      end

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
