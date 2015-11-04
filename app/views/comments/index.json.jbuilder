json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :points, :user_id, :submission_id
  json.url comment_url(comment, format: :json)
end
