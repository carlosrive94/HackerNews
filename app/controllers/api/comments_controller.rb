module API
    class CommentsController < ActionController::Base
        before_action :addheaders
        skip_before_action :verify_authenticity_token
        
        def index
            @comments = Comment.all
            respond_to do |format|
                format.xml { render xml: @comments }
                format.json { render json: @comments }
            end
        end
        
        def create
        end
    
        def show
            @comment = Comment.find(params[:id]);
            respond_to do |format|
                format.xml { render xml: @comment }
                format.json { render json: @comment }
            end
        end
        
        def replies
            @comment = Comment.find(params[:id]);
            respond_to do |format|
                format.xml { render xml: @comment.replies }
                format.json { render json: @comment.replies }
            end
        end
    end
end