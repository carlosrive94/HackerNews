module API
    class SubmissionsController < ApplicationController

        skip_before_action :verify_authenticity_token
        
        def index
            @submissions = Submission.all
            respond_to do |format|
                format.xml { render xml: @submissions }
                format.json { render json: @submissions }
            end
        end
        
        def ask
            @submissions = Submission.where(url: [nil, ""])
            respond_to do |format|
                format.xml { render xml: @submissions }
                format.json { render json: @submissions }
            end
        end
        
        def links
            @submissions = Submission.where(content: [nil, ""])
            respond_to do |format|
                format.xml { render xml: @submissions }
                format.json { render json: @submissions }
            end
        end
        
        def create
            @title = params["title"]
            @url = params["url"]
            @content = params["content"]
            if ((@url == nil and @content != nil) or (@url != nil and @content == nil))
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
            else
                render json: '{"response": "content or url"}', :status => 400
            end
        end
        
        def delete
           # http://stackoverflow.com/questions/23927314/rails-render-xml
            @submission = Submission.find(params[:id])
            respond_to do |format|
                @comments = @submission.comments
                if @submission.destroy
                    @comments.each do |comment|
                        comment.replies.each do |reply|
                            reply.destroy
                        end
                        comment.destroy
                    end
                    format.json { render json: '{"response": "succesfully deleted"}' }
                    format.xml { render xml:"<response>succesfully deleted</response>" }
                end
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "submission not found"}', :status => 404
        end
        
        #@submission.comments.each do |comment|
        

        def show
            @submission = Submission.find(params[:id])
            respond_to do |format|
                format.xml { render xml: @submission }
                format.json { render json: @submission }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "submission not found"}', :status => 404
        end
        
        def comments
           @submission = Submission.find(params[:id])
           respond_to do |format|
                format.xml { render xml: @submission.comments }
                format.json { render json: @submission.comments }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "submission not found"}', :status => 404
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
                render json: '{"response": "submission not found"}', :status => 404
        end
    end
end