module API
    class RepliesController < ApplicationController
        
        def index
            @replies = Reply.all;
            respond_to do |format|
                format.xml { render xml: @replies }
                format.json { render json: @replies }
            end
        end
        
        def create
        end
            
        def show
            @reply = Reply.find(params[:id]);
            respond_to do |format|
                format.xml { render xml: @reply }
                format.json { render json: @reply }
            end
        end    
        
    end
end