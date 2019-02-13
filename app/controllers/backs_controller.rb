class BacksController < ApplicationController
    def new
        @back = Back.new
    end
    def create
        card = Card.find(params[:back][:card_id])
        @back = card.backs.build(back_params)
        if @back.save
            redirect_to card_url(card.id)
        else
            flash[:notice] = 'Wrong file type. Please upload an image or audio'
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
            flash[:success] = 'Back updated!'
            redirect_to @back.card
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
