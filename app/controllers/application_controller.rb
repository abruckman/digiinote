class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def get_credentials
    Google::Auth::UserRefreshCredentials.new(
       client_id: ENV['OAUTH'],
       client_secret: ENV['CLIENT_SECRET'],
       scope: [
         "https://www.googleapis.com/auth/drive",
         "https://spreadsheets.google.com/feeds/",
       ],
       redirect_uri: BASE_URL )
  end
end
