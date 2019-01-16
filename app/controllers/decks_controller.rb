class DecksController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:destroy, :edit]
    def new 
        @deck = Deck.new
    end

    def create 
        @deck = current_user.decks.build(deck_params)
        if @deck.save 
            flash[:success] = "Deck created!"
            redirect_to decks_url
        else
            flash[:notice].now = 'SOMETHING WRONG HAS HAPPENED'
            render 'new'
        end
    end

    def edit 
        @deck = current_user.decks.find(params[:id])
    end

    def update 
        @deck = current_user.decks.find(params[:id])
        if @deck.update_attributes(deck_params)
            flash[:success] = 'Deck updated!'
            redirect_to @deck
        else
            flash[:notice].now = 'Something terrible has happened'
            render 'edit'
        end
    end

    def show 
        @deck = current_user.decks.find(params[:id])
    end

    def index 
        @decks = current_user.decks.all
    end

    def destroy 
        @deck = Deck.find(params[:id])
        @deck.destroy
        redirect_to action: "index"
    end
    private 
    def deck_params
        params.require(:deck).permit(:name,:description)
    end

    def correct_user 
        @deck = current_user.decks.find_by(id: params[:id])
        if @deck.nil?
            flash[:notice] = "Unauthorised action!"
            redirect_to user_session_url 
        end
    end
end
