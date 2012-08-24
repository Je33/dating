class SmsController < ApplicationController
  def get
    if params[:phone] && params[:message]
      _mess = params[:message].split(/\s/)
      case _mess[0]
        when "1"

        when "+"

        else

      end
    end
  end
  def set

  end
end
