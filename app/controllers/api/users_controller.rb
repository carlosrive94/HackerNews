module API
    class UsersController < ApplicationController
        before_action :addheaders
        skip_before_action :verify_authenticity_token
      
        def index
            @users = User.all
            respond_to do |format|
                format.xml { render xml: @users }
                format.json { render json: @users }
            end
        end
        
        def create
        end
        
        def edit
        end
    
        def show
            @user = User.find(params[:id]);
            respond_to do |format|
                format.xml { render xml: @user }
                format.json { render json: @user }
            end
        end
        
        def submissons
            @user = User.find(params[:id]);
            respond_to do |format|
                format.xml { render xml: @user.submissions }
                format.json { render json: @user.submissions }
            end
        end
        
        def comments
           @user = User.find(params[:id]);
           respond_to do |format|
                format.xml { render xml: @user.comments }
                format.json { render json: @user.comments }
            end
        end
        
        
        def replies
            @user = User.find(params[:id]);
            respond_to do |format|
                format.xml { render xml: @user.replies }
                format.json { render json: @user.replies }
            end
        end
        
    end 
end      
