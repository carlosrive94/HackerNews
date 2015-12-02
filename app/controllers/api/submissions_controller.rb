module API
    class SubmissionsController < ApplicationController
        #before_action :addheaders
        skip_before_action :verify_authenticity_token
        
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
            @submission = Submission.new(:title => @title, :url => @url, :content => @content, :points => 0, :user_id => 1)
            respond_to do |format|
                if @submission.save
                  format.json { render json: @submission }
                  format.xml { render xml: @submission }
                else
                  format.json { render json: @submission.errors, status: :unprocessable_entity }
                  format.xml { render xml: @submission.errors, status: :unprocessable_entity }
                end
            end
        end
        
        def delete
           # http://stackoverflow.com/questions/23927314/rails-render-xml
            @submission = Submission.find(params[:id])
            respond_to do |format|
                if @submission.destroy
                    format.json { render json: '{"response": "succesfully deleted"}' }
                    format.xml { render xml:"<response>succesfully deleted</response>" }
                else
                     #format.json { render json: @submission.errors, status: :unprocessable_entity }
                     #format.xml { render xml: @submission.errors, status: :unprocessable_entity }
                end
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "submission not found"}'
        end
        

        def show
            @submission = Submission.find(params[:id])
            respond_to do |format|
                format.xml { render xml: @submission }
                format.json { render json: @submission }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "submission not found"}'
        end
        
        def comments
           @submission = Submission.find(params[:id])
           respond_to do |format|
                format.xml { render xml: @submission.comments }
                format.json { render json: @submission.comments }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "submission not found"}'
        end
        
        def upvote
            @submission = Submission.find(params[:id])
            @submission.points += 1
            respond_to do |format|
                if @submission.save
                    format.json { render json: @submission }
                    format.xml { render xml: @submission }
                else
                    format.json { render json: @submission.errors, status: :unprocessable_entity }
                    format.xml { render xml: @submission.errors, status: :unprocessable_entity }
                end
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "submission not found"}'
        end
        
        #def addheaders
         #   response.headers['Access-Control-Allow-Origin'] = 'http://swagger.io'
         #   response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept'
        #end
    end
end