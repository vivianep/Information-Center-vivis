class SessionsController < ApplicationController
  
  def new

  end


 

 def expa_authentication (email, senha)

    url = 'https://auth.aiesec.org/users/sign_in' #Store the url for authenticate at EXPA
    agent = Mechanize.new  #Initialize an instance to start to work with mechanize
    page = agent.get(url)
    aiesec_form = page.form() #Selects the form on the page by its name. However this form doens't have a name
    aiesec_form.field_with(:name => 'user[email]').value = email #Set the email field with the args of this function
    aiesec_form.field_with(:name => 'user[password]').value = senha #Set the password field with the seccond arg of this function
    page = agent.submit(aiesec_form, aiesec_form.buttons.first) #submit the form
    if page.code.to_s == '200' #Verify if the page's code is 200, which means its all right
      cj = agent.cookie_jar  #Store the cookie at cj variable
      if cj.jar['experience.aiesec.org'] == nil  #Verify if inside the cookie exist an experience.aiesec.org
        return nil
      else  
        #session[:token] = cj.jar['experience.aiesec.org']['/']["expa_token"].value[44,64] #Take the token code for API. First version
        token = cj.jar['experience.aiesec.org']['/']["expa_token"].value #take the expa. Working on November 9, 2015
        puts "#{session[:token]}"
        return token
        #request the expa's current user data
      end

    end
    return nil
  
  end 

  private :expa_authentication
 
  #Method that controls the welcome view
  # @param email [String] receives the params from the form on login
  # @param senha [String] receives the params from the form on login
  def create(email = params[:my_email], senha = params[:my_password])
   
        session[:token]= expa_authentication(email,senha) 
        if session[:token]== nil
          flash[:warning] = "E-mail ou senha inválida"
          return redirect_to  "/authentication/login"       
        else
          #session[:token] = cj.jar['experience.aiesec.org']['/']["expa_token"].value[44,64] #Take the token code for API. First version
          #request the expa's current user data
          @request = "https://gis-api.aiesec.org:443/v1/current_person.json?access_token=#{session[:token]}"
          resp = Net::HTTP.get_response(URI.parse(@request))
          data = resp.body
          @current_person = JSON.parse(data)
          #Check if the member is affiliated to AIESEC Brazil
          if  @current_person['person']['home_mc']['id'] != 1606
              flash[:warning] = "BAZICON is only available for AIESEC in Brazil members"
              return redirect_to  "/authentication/login"
          end
          #Find the user on system
          @user = User.find_by_email(params[:my_email])

          #create sessions if the user exist, else create a user automaticaly 
          if @user
            reset_session
            session[:user_id] = @user.id
            @user.local_commitment = @current_person['person']['home_lc']['id']
            User.cache_photo(session[:user_id])
            redirect_to authentication_welcome_path
            #@user.photo_url = @current_person["person"]["profile_photo_url"]
          else
            @user = User.new(:name => @current_person['person']['full_name'], :email => email )
            @user.photo_url = @current_person['person']["profile_photo_url"]
            @user.postion = @current_person['current_position']['team']['team_type']
            @user.local_commitment = @current_person['person']['home_lc']['id']
            @user.save
            @user_name = @user.name
            session[:user_id] = @user.id
            User.cache_photo(session[:user_id])
            redirect_to  authentication_welcome_path
          end
        end
  end


  #Destroy the session
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end



   


end
