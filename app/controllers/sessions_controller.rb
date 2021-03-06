class SessionsController < ApplicationController
  force_ssl
      def new
      end

      def create
        player = Player.find_by_email(params[:email])
        if player && player.authenticate(params[:password])
          session[:player_id] = player.id
          redirect_to games_path, :notice => "Logged in!"
        else
          flash.now.alert = "Invalid email or password"
          render "new"
        end
      end

      def destroy
        session[:player_id] = nil
        redirect_to new_player_path, :notice => "Logged out!"
      end
    end