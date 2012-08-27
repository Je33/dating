class SmsController < ApplicationController

  def get

    @resp = {}

    if !params[:phone].blank? && !params[:message].blank?

      # user from
      u_from = User.find_by_phone(params[:phone])
      # subscription status
      allow = false
      # if date subscription not expired yet
      if !u_from.nil? && u_from.subscription <= Time.now
        allow = true
      end

      _mess = params[:message].split(/\s/)
      # action step
      @resp[:act] = "unk"

      #current action
      case _mess[0]

        #registration user
        when "0"
          @resp[:act] = "reg"
          if User.where({:phone})
          @user = User.new({
              :phone => params[:phone],
              :password => params[:phone],
              :subscription => Time.now + 1.month
                   })
          if @user.save
            @resp[:text] = "<font color='green'>User created successfully. Please fill in the fields bellow:</font>".html_safe
          else
            @resp[:text] = "Fatal error: " + @user.errors.to_s
          end

        # request user contacts
        when "+"
          @resp[:act] = "req"
          if allow
            # request users
          end

        else
          # sending messages to users
          if !_mess[0].nil? && _mess[0].to_i > 0
            @resp[:act] = "mes"
            if User.where(:id => _mess[0].to_i).exists?
              u_to = User.find(_mess[0])
              @resp[:text] = "To ##{u.id} #{u.name}, #{u.age}: #{params[:message].gsub(/#{_mess[0]}\s/, '')}"
            else
              @resp[:text] = '<font color="red">User not found</font>'.html_safe
            end
          end
        end

    end
  end

end
