class App < Sinatra::Base
  get "/" do
    slim :index
  end

  get "/application.js" do
    coffee :application
  end

  get "/application.css" do
    sass :application
  end
end
