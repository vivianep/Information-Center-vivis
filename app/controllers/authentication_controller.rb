require 'rubygems'
require 'mechanize'
require 'dropbox_sdk'
require 'uri'
require 'net/http'
require 'json'

# @author Mauro Victor
class AuthenticationController < ApplicationController
# Class that control the Authenticatiom system and its views
  
  layout 'login', :only => [:login]
  
  include AuthenticationHelper #Use this module of helpers
  
  APP_KEY = '1g9mnjegs1l7j3m'
  APP_SECRET = 'glhnoqva181wmpa'

  def welcome
    $client = DropboxClient.new("siZpe-o98xoAAAAAAAAAl9HJEsrdDz0EPFebqJHr-oZryn0TL2aNhcGVSQvEjm71")
  end

  def files(search=params[:search])
    if search == nil 
      @archives = Archive.where({show: true, path: session[:dbox_path]})
    else
      files_list = Archive.all.pluck(:name)
      search_list = Array.new
      files_list.each do |f|
        search_list << f.to_s if f.to_s.include?(search)
      end
      @archives = Archive.where({show: true, path: session[:dbox_path], name: search_list})
    end

  end

  def login 
    if current_user
      #request the expa's current user data
      @request = "https://gis-api.aiesec.org:443/v1/current_person.json?access_token=#{session[:token]}"
      resp = Net::HTTP.get_response(URI.parse(@request))
      data = resp.body
      @current_person = JSON.parse(data)
      #Find the user on system
      @user = User.find_by_email(params[:my_email])
      redirect_to authentication_welcome_path
    else
      render 'login'
    end
  end


  # Takes the params for navigation 
  # @param content [String] path of the actual directory
  # @param upload[String] upload file to be uploaded
  # @param new_folder_name [String] name of the new folder name in case the user fulfilled a form to create a new one
  # @param files_array [Array] array of files to check if the file to be uploaded alaready exists
  # @param rename [Array] new and old name from the file that will be renamed
  # @param move [Array] Origin path and target path for the file will be moved
  # @param page [Number] Number of the page passed by the user through it's navigation
  # @param remove [String] Path of file to be removed on the request
  def navigation_params (content=params[:parent_id])
    #Store the path into a global variable because this variable is necessary in others methods.
    #If it is being requested by Arquivos's link set the root as "/"
    if request.get?
      session[:dbox_path] = "/"
    else
      session[:dbox_path] = content
    end
    redirect_to authentication_files_path
  end

  def refresh 
    recs = Archive.all.pluck(:name)
    dbox_files = Array.new
    root_metadata = $client.metadata(session[:dbox_path])['contents']

    root_metadata.each do |file|
      unless Archive.find_by_name(file['path'].split('/').last)
        record = Archive.new
        record.name = file['path'].split('/').last
        record.path = session[:dbox_path]
        record.dir = file['is_dir']
        record.show = true
        record.save
      end
      dbox_files << file['path'].split('/').last 
    end

    recs.each do |rec|
      unless dbox_files.include?(rec)
        Archive.find_by_name(rec).destroy
      end
    end
    redirect_to authentication_files_path
  end
  
  def upload(upload=params[:file], path=params[:parent_id])
    unless upload == nil || Archive.find_by_name("#{upload.original_filename}")
      file = open(upload.path())
      response = $client.put_file("#{session[:dbox_path]}/#{upload.original_filename}", file)
      #Save a record with the data about who uploaded the file
      record = Archive.new
      record.name = upload.original_filename
      record.owner = current_user.name
      record.local_commitment = current_user.local_commitment
      record.path = path
      record.show = true
      record.dir = false
      record.save
    end
    redirect_to authentication_files_path
  end

  #def new_folder(new_folder=params[:folder_name])
  #  unless new_folder == nil
  #    $client.file_create_folder("#{session[:dbox_path]}/#{new_folder}")
  #    record = Archive.new
  #    record.name = new_folder
  #    record.path = session[:dbox_path]
  #    record.dir = true
  #    record.save
  #  end
  #  redirect_to authentication_files_path
  #end

  def rename(rename=[params[:rename_new_name], params[:rename_old_name]])
    unless rename[0] == nil
      $client.file_move("#{session[:dbox_path]}/#{rename[1]}","#{session[:dbox_path]}/#{rename[0]}")
      record = Archive.find_by_name(rename[1])
      record.name = rename[0]
      record.save
    end
    redirect_to authentication_files_path
  end

  def move(move=[params[:move_to], params[:move_from]])
    record = Archive.find_by_name(move[1])
    record.path = (session[:dbox_path] == "/") ? "/#{move[0]}/" : "#{session[:dbox_path]}/#{move[0]}/"
    record.save
    redirect_to authentication_files_path
  end

  def remove(remove=params[:to_remove])
    record = Archive.find_by_name(remove)
    record.show = false
    record.save
    redirect_to authentication_files_path
  end
  
  helper_method :current_user
  
  #define the current user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    return @current_user
  end

  def require_user
    redirect_to '/login' unless $current_user
  end
  
  
end
