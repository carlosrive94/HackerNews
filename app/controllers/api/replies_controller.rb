module API
    class RepliesController < ApplicationController
        skip_before_action :verify_authenticity_token
       
        def index
            @replies = Reply.all
            respond_to do |format|
                format.xml { render xml: @replies }
                format.json { render json: @replies }
            end
        end
        
        def create
            @content = params["content"]
            @comment_id = params["comment_id"]
            @reply = Reply.new(:content => @content, :points => 0, :user_id => 1, :comment_id => @comment_id)
            respond_to do |format|
                if @reply.save
                  format.json { render json: @reply }
                  format.xml { render xml: @reply }
                else
                  format.json { render json: @reply.errors, status: :unprocessable_entity }
                  format.xml { render xml: @reply.errors, status: :unprocessable_entity }
                end
            end
        end
            
        def show
            @reply = Reply.find(params[:id])
            respond_to do |format|
                format.xml { render xml: @reply }
                format.json { render json: @reply }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "reply not found"}', :status => 404
        end    
        
        def upvote
            @reply = Reply.find(params[:id])
            @reply.points += 1
            respond_to do |format|
                if @reply.save
                    format.json { render json: @reply }
                    format.xml { render xml: @reply }
                else
                    format.json { render json: @reply.errors, status: :unprocessable_entity }
                    format.xml { render xml: @reply.errors, status: :unprocessable_entity }
                end
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "reply not found"}', :status => 404
        end
    end
end