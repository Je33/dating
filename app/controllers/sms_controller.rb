class SmsController < ApplicationController

  def get

    @resp = {}

    if !params[:user_id].blank? && params[:user_id].to_i > 0
      u = User.find(params[:user_id])
      if u.nil?
        @resp[:text] = "<font color='red'>User not found</font>".html_safe
      else
        u.update_attributes(params[:user])
        @resp[:text] = "<font color='green'>User updated</font>".html_safe
      end
    end

    if !params[:phone].blank? && !params[:message].blank?

      # user from
      u_from = User.find_by_phone(params[:phone])
      # subscription status
      # if user exist and date subscription not expired yet
      if !u_from.nil? && u_from.subscription <= Time.now
        allow = true
      else
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
          if u_from
            @user = u_from
            @resp[:text] ||= "<font color='green'>User exist. Please fill in the fields bellow:</font>".html_safe
          else
            @user = User.new({
                :phone => params[:phone],
                :password => params[:phone],
                :subscription => Time.now + 1.month
                     })
            if @user.save
              @resp[:text] ||= "<font color='green'>User created successfully. Please fill in the fields bellow:</font>".html_safe
            else
              @resp[:text] ||= "Fatal error: " + @user.errors.to_s
            end
          end

        # request user contacts
        when "+"
          @resp[:act] = "req"
          if u_from && allow
            @list = User.where({:sex => u_from.search_sex, :age => [u_from.search_age_from..u_from.search_age_to], :search_sex => u_from.sex}).where("search_age_from <= ? AND search_age_to >= ? AND id != ?", u_from.age, u_from.age, u_from.id)
          else
            @resp[:text] ||= "<font color='red'>User not found or subscription period has expired".html_safe
          end

        else
          # sending messages to users
          if !_mess[0].nil? && _mess[0].to_i > 0
            @resp[:act] = "mes"
            if User.where(:id => _mess[0].to_i).exists? && allow
              u_to = User.find(_mess[0])
              @resp[:text] = "To ##{u_to.id} #{u_to.name}, #{u_to.age}: #{params[:message].gsub(/#{_mess[0]}\s/, '')}"
            else
              @resp[:text] = '<font color="red">User not found or subscription period has expired</font>'.html_safe
            end
          end
        end

    end
  end

end
