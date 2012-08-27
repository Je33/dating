module ApplicationHelper
  def get_act(act)
    case act
      when "req"
        "Request users"
      when "reg"
        "Registration new user"
      when "mes"
        "Sending message"
      when "unk"
        "<font color='red'>Unknown action</font>".html_safe
      else
        ""
    end
  end
end
