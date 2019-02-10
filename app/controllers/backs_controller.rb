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
    def delete

    end

    def edit

    end

    def update

    end
    private
    def back_params
        params.require(:back).permit(:text_field,:media)
    end
end
