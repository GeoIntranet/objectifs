module Krs
  class Create < ApplicationService

    def initialize(id)
      @id = id
    end

    def call
      kr = Kr.new({title:"placeholder",weight:0,objectif_id:@id})
      if kr.save
        data = {status: :ok,msg:"Kr created successfully",data:kr}
      else
        data = {status: :error,msg:"Error KR creation",data:{}}
      end

      data
    end

  end
end
