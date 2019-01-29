class CardsController < ApplicationController
    before_action :authenticate_user!
    def new 
        deck = current_user.decks.find(params[:id])
        @card = deck.cards.new
    end

    def create 
        deck = current_user.decks.find(params[:card][:deck_id])
        @card = deck.cards.build()
        if @card.save && @card.fronts.create(front_params) && @card.backs.create(back_params)
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
        if @card.update_attributes(fronts_attributes: [card_params[:fronts_attributes]])
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

    def show
        @card =  Card.find(params[:id])
    end
    private 
    def front_params
        params.require(:fronts_attributes).permit(:text_field)
    end

    def back_params
        params.require(:backs_attributes).permit(:text_field)
    end
end
