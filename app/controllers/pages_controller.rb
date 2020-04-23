class PagesController < ApplicationController
    def home
        redirect_to articles_path if helpers.logged_in?
    end
end
