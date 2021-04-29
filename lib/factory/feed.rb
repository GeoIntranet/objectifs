module Factory
  class Feed

    # Factory::Feed.new.exec
    def exec(nb_item = 2)
      (0..nb_item).each do |item|
        objectif = Objectif.new({title:"Objectif_#{item}",weight:10})
        objectif.save

        (0..nb_item).each do |item_kr|
          Kr.new({title:"Kr_#{item_kr}",weight:10,objectif_id:objectif.id}).save
        end
      end
    end


  end
end