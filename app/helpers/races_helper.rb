module RacesHelper
  def print_nickname_dash(racer)
      if !racer.nickname.nil?
          return " - " + racer.nickname
      end
  end
end
