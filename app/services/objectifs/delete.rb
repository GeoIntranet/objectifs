module Objectifs
  class Delete < ApplicationService

    def initialize(objectif)
      @objectif = objectif
      @id = @objectif.id
    end

    def call
      if @objectif.delete
        delete_krs_associated
        data = {status: :ok,msg:"Objectif deleted successfully"}
      else
        data = {status: :error,msg:"Error",data:{}}
      end

      data
    end

    def delete_krs_associated
      Kr.where(objectif_id:@id).delete_all
    end

  end
end