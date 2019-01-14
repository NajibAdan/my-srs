class CardsController < ApplicationController
    before_action :authenticate_user!
    def new 
        deck = current_user.decks.find(params[:id])
        @card = deck.cards.new
    end

    def create 
        deck = current_user.decks.find(params[:card][:deck_id])
        @card = deck.cards.build(card_params)
        if @card.save 
            flash[:success] = 'Card created!'
            redirect_to action: "index", deck_id: @card.deck.id
        else
            flash[:notice] = 'Something terrible has happened'
            render 'new'
        end
    end

    def edit 
        @card = Card.find(params[:id])
    end

    def update 
        @card = Card.find(params[:id])
        if @card.update_attributes(card_params)
            flash[:success] = "Update was successful"
            redirect_to action: "index", deck_id: @card.deck.id
        else
            flash[:notice].now = "Something terrible has happened"
            render 'edit'
        end
    end

    def index 
        deck = current_user.decks.find(params[:deck_id])
        @cards = deck.cards.all
    end

    def destroy 
        @card = Card.find(params[:id])
        if @card.destroy 
            flash[:sucess] = "Card destroyed"
            redirect_to action: "index", deck_id: @card.deck.id
        else
            flash[:notice].now = "Something terrible has happened"
            render 'index'
        end 
    end
    private 
    def card_params
        params.require(:card).permit(:front,:back)
    end
end
