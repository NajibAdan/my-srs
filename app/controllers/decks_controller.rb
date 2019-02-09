class DecksController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:destroy, :edit]
    def new 
        @deck = Deck.new
    end

    def create 
        @deck = current_user.decks.build(
            option: Option.find_by(id: deck_params[:option]),
            name: deck_params[:name],
            description: deck_params[:description ]
        )
        if @deck.save 
            flash[:success] = "Deck created!"
            redirect_to decks_url
        else
            flash.now[:notice] = 'SOMETHING WRONG HAS HAPPENED'
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
        @study = @deck.study
    end

    def index 
        @decks = current_user.decks.all
    end

    def destroy 
        @deck = Deck.find(params[:id])
        @deck.destroy
        redirect_to action: "index"
    end

    def study
        @card = Deck.find(params[:id]).study.first
    end
    
    def study_receiver 
        set_interval(Card.find(params['card']['card_id']),params['card']['status'])
        redirect_to action: "study", id: params['card']['deck_id']
    end
    private 
    def options_params
        params.require(:deck).permit(:option)
    end
    def deck_params
        params.require(:deck).permit(:name,:description,:option)
    end
    def correct_user 
        @deck = current_user.decks.find_by(id: params[:id])
        if @deck.nil?
            flash[:notice] = "Unauthorised action!"
            redirect_to user_session_url 
        end
    end
    def set_interval(card,response)
        option = card.deck.option
        case response
        when '1'
            next_interval = card.ease * card.interval * (option.easyBonus/100)
            new_ease = card.ease + 0.15
        when '3'
            next_interval = (card.interval * (option.newInterval/100)) * card.interval
            new_ease = card.ease - 0.20
        else
            next_interval = card.interval * card.ease * (option.intervalModifier/100)
            new_ease = card.ease
        end
        day_to_study = Date.today + next_interval/100
        card.update_attributes(interval: next_interval,ease: new_ease,day_to_study: day_to_study)
    end
end
