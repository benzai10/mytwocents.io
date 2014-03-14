module ApplicationHelper


  def get_mood(mood_id)
    case mood_id

    when 100
      return "fa fa-smile-o"

    when 50
      return "fa fa-meh-o"

    when 1
      return "fa fa-frown-o"

    end 
  end

end
