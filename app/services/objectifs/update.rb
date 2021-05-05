module Objectifs
  class Update < ApplicationService

    def initialize(objectif,obj_params)
      @objectif = objectif
      @params = obj_params
    end

    def call


      if @objectif.update(@params)
        data = {status: :ok,msg:"Objectif updated successfully",data:@objectif}
      else
        data = {status: :error,msg:"Error",data:{}}
      end

      data
    end
  end
end