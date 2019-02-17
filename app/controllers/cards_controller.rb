class CardsController < ApplicationController
    include CardsHelper
    before_action :authenticate_user!
    before_action :correct_user, only: [:destroy]
    def new 
        deck = current_user.decks.find(params[:id])
        @card = deck.cards.new
    end

    def create 
        deck = current_user.decks.find(params[:card][:deck_id])
        @card = deck.cards.build(card_params)
        if @card.save && @card.fronts.create(front_params) && @card.backs.create(back_params)
            flash[:success] = 'Card created!'
            redirect_to action: "index", deck_id: @card.deck.id
        else
            render 'new'
        end
    end

    def edit 
        @card = Card.find(params[:id])
    end

    def update 
        @card = Card.find(params[:id])
        if @card.update_attributes(fronts_attributes: [card_params[:fronts_attributes]])
            flash[:success] = "Update was successful"
            redirect_to action: "index", deck_id: @card.deck.id
        else
            render 'new'
        end
    end

    def index 
        @deck = current_user.decks.find(params[:deck_id])
        @cards = @deck.cards.all
    end

    def destroy 
        @card = Card.find(params[:id])
        if @card.destroy 
            flash[:sucess] = "Card destroyed"
            redirect_to action: "index", deck_id: @card.deck.id
        end 
    end

    def show
        @card =  Card.find(params[:id])
    end
    
end
