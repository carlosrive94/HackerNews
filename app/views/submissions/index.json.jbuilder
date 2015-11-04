json.array!(@submissions) do |submission|
  json.extract! submission, :id, :title, :url, :points, :content, :user_id
  json.url submission_url(submission, format: :json)
end
