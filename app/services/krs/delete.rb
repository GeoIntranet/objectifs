module Krs
  class Delete < ApplicationService

    def initialize(kr)
      @kr = kr
    end

    def call
      if @kr.delete
        data = {status: :ok,msg:"KR deleted successfully"}
      else
        data = {status: :error,msg:"Error",data:{}}
      end
      data
    end

  end
end