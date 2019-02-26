class BacksController < ApplicationController
    def new
        @back = Back.new
    end
    def create
        card = Card.find(params[:back][:card_id])
        @back = card.backs.build(back_params)
        if @back.save
            flash[:success] = 'Back field created!'
            redirect_to card_url(card.id)
        else
            redirect_to action: "new", card_id: card.id
        end
    end
    def edit
        @back = Back.find(params[:id])
    end

    def update
        @back = Back.find(params[:id])
        @back.media.purge
        if @back.update_attributes(back_params)
            flash[:success] = 'Back field updated!'
            redirect_to @back.card
        else
            redirect_to action: "new", card_id: @back.card.id
        end
    end

    def destroy 
        @back = Back.find(params[:id])
        if @back.destroy
            flash[:success] = "Back field destroyed"
            redirect_to @back.card
        end
    end
    private
    def back_params
        params.require(:back).permit(:text_field,:media)
    end
end
