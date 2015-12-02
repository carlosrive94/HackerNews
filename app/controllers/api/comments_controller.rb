module API
    class CommentsController < ActionController::Base
        skip_before_action :verify_authenticity_token
        
        def index
            @comments = Comment.all
            respond_to do |format|
                format.xml { render xml: @comments }
                format.json { render json: @comments }
            end
        end
        
        def create
            @content = params["content"]
            @submissionId = params["submission_id"]
            @comment = Comment.new(:content => @content, :points => 0, :user_id => 1, :submission_id => @submissionId)
            respond_to do |format|
                if @comment.save
                  format.json { render json: @comment }
                  format.xml { render xml: @comment }
                else
                  format.json { render json: @comment.errors, status: :unprocessable_entity }
                  format.xml { render xml: @comment.errors, status: :unprocessable_entity }
                end
            end
        end
    
        def show
            @comment = Comment.find(params[:id]);
            respond_to do |format|
                format.xml { render xml: @comment }
                format.json { render json: @comment }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "comment not found"}'
        end
        
        def replies
            @comment = Comment.find(params[:id]);
            respond_to do |format|
                format.xml { render xml: @comment.replies }
                format.json { render json: @comment.replies }
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "comment not found"}'
        end
        
        def upvote
            @comment = Comment.find(params[:id])
            @comment.points += 1
            respond_to do |format|
                if @comment.save
                    format.json { render json: @comment }
                    format.xml { render xml: @comment }
                else
                  format.json { render json: @comment.errors, status: :unprocessable_entity }
                  format.xml { render xml: @comment.errors, status: :unprocessable_entity }
                end
            end
            rescue ActiveRecord::RecordNotFound
                render json: '{"response": "comment not found"}'
        end
    end
end