
module ApplicationHelper
    def timestring_to_int(timestring)

      if timestring.length<1
        return 0
      end

      start = Time.parse "00:00:00"
      duration = Time.parse timestring

      return (duration - start).to_i
    end
end