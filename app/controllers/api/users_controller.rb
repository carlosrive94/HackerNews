module API
    class UsersController < ApplicationController
        skip_before_action :verify_authenticity_token
      
        def index
            @users = User.all
            respond_to do |format|
                format.xml { render xml: @users }
                format.json { render json: @users }
            end
        end
        

        def edit
            @user = User.find(params[:id])
            @user.about = params["about"]
            respond_to do |format|
                if @user.save
                    format.json { render json: @user }
                    format.xml { render xml: @user }
                else
                    format.json { render json: @user.errors, status: :unprocessable_entity }
                    format.xml { render xml: @user.errors, status: :unprocessable_entity }
                end
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "user not found"}', :status => 404
        end
    
        def show
            @user = User.find(params[:id])
            respond_to do |format|
                format.xml { render xml: @user }
                format.json { render json: @user }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "user not found"}', :status => 404
        end
        
        def submissions
            @user = User.find(params[:id])
            respond_to do |format|
                format.xml { render xml: @user.submissions }
                format.json { render json: @user.submissions }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "user not found"}', :status => 404
        end
        
        def comments
           @user = User.find(params[:id])
           respond_to do |format|
                format.xml { render xml: @user.comments }
                format.json { render json: @user.comments }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "user not found"}', :status => 404
        end
        
        
        def replies
            @user = User.find(params[:id])
            respond_to do |format|
                format.xml { render xml: @user.replies }
                format.json { render json: @user.replies }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "user not found"}', :status => 404
        end
        
    end 
end      
