module Objectifs
  class Create < ApplicationService

    def initialize()
    end

    def call
      objectif = Objectif.new({ title: "placeholder", weight: 0 })
      if objectif.save
        data = { status: :ok, msg: "Objectif created successfully", data: objectif }
      else
        data = { status: :error, msg: "Error", data: {} }
      end

      data
    end

  end
end
