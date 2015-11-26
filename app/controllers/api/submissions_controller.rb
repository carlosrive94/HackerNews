module API
    class SubmissionsController < ApplicationController
        before_action :addheaders
        
        def index
            @submissions = Submission.all
            respond_to do |format|
                format.xml { render xml: @submissions }
                format.json { render json: @submissions }
            end
        end
        
        def create
            @title = params["title"]
            @url = params["url"]
            @content = params["content"]
            @submission = Submission.new(:title => @title, :url => @url, :content => @content, @points => 0, :user_id => 1)
            respond_to do |format|
                if @submission.save
                  format.json { render :show, status: :created, location: @submission }
                  format.xml { render :show, status: :created, location: @submission }
                else
                  format.json { render json: @submission.errors, status: :unprocessable_entity }
                  format.xml { render xml: @submission.errors, status: :unprocessable_entity }
                end
            end
        end
        
        def delete
            @submission = Submission.find(params[:id])
            @submission.destroy
        end
        

        def show
            @submission = Submission.find(params[:id])
            respond_to do |format|
                format.xml { render xml: @submission }
                format.json { render json: @submission }
            end
        end
        
        def comments
           @submission = Submission.find(params[:id])
           respond_to do |format|
                format.xml { render xml: @submission.comments }
                format.json { render json: @submission.comments }
            end
            
        end
        
        def addheaders
            response.headers['Access-Control-Allow-Origin'] = 'http://swagger.io'
            response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept'
        end
    end
end