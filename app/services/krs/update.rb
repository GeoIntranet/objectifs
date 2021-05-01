module Krs
  class Update < ApplicationService

    def initialize(kr,kr_params)
      @kr = kr
      @params = kr_params
    end

    def call
      if @kr.update(@params)
        data = {status: :ok,msg:"KR updated successfully",data:@kr}
      else
        data = {status: :error,msg:"Error",data:{}}
      end

      data
    end
  end
end