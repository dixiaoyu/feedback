class SessionsController < ApplicationController
  def new
    if !cookies.signed[:remember_token].nil?
      #redirect_to current_user  
      if current_user.user_group=="natas"
        redirect_to natas_home_path(:id=>cookies.signed[:remember_token])  
      elsif current_user.user_group=="customer"
        redirect_to cus_home_path(:id=>cookies.signed[:remember_token])
      elsif #current_user.user_group=="member"
        redirect_to mbr_home_path(:id=>cookies.signed[:remember_token])        
      end    
    end    
  end
  
  def create
    user=User.authenticate(params[:session][:user_id],params[:session][:password])
    session[:password] = params[:session][:password]
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."  
      render 'new'
    else
      if params[:remember]=="1"
        cookies.signed[:remember_token] = {:value=>[user.id, user.user_id], :expires=>15.days.from_now}          
      else
        cookies.signed[:remember_token] = {:value=>[user.id, user.user_id]}          
      end
      user.update_attributes(:last_login=>Time.now, :updated_by=>params[:session][:user_id])
      sign_in user 
      if user.user_group=="admin"
        redirect_to user
      elsif user.user_group=="natas"
        redirect_to natas_home_path(:user_id=>params[:session][:user_id])
      elsif user.user_group=="customer"    
        redirect_to cus_home_path
      elsif #user.user_group=="member"
        redirect_to mbr_home_path(:user_id=>params[:session][:user_id])
      end         
      #redirect_to home_path(:id=>user.user_id.strip())  
    end       
  end
  
  
  
  
  def destroy
    sign_out
    redirect_to signin_path     
  end
end

