class FrontsController < ApplicationController
    def new
        @front = Front.new
    end
    def create
        card = Card.find(params[:front][:card_id])
        @front = card.fronts.build(front_params)
        if @front.save
            redirect_to card_url(card.id)
        else

        end
    end
    def delete

    end

    def edit

    end

    def update

    end
    private
    def front_params
        params.require(:front).permit(:text_field)
    end
end
