module Objectifs
  class List < ApplicationService

    def initialize()
    end

    def call
      Objectif.includes(:krs).all.map do |objectif|
        objectif.as_json(include: :krs)
      end
    end
  end
end