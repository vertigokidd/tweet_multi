get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do

  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  params = @access_token.params
  user = User.create(username: params[:screen_name],oauth_token: params[:oauth_token], oauth_secret: params[:oauth_token_secret])
  session[:user_id] = user.id
  erb :index
  
end


get '/tweet' do
  erb :create_tweet
end


post '/newtweet' do
  username = User.find(session[:user_id])
  user = User.find(session[:user_id])
  user = Twitter::Client.new(
    :oauth_token => user.oauth_token,
    :oauth_token_secret => user.oauth_secret
  )
  user.update(params[:tweet])
end