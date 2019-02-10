class FrontsController < ApplicationController
    def new
        @front = Front.new
    end
    def create
        card = Card.find(params[:front][:card_id])
        @front = card.fronts.build(front_params)
        if @front.save
            flash[:success] = 'Front created!'
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
    def front_params
        params.require(:front).permit(:text_field,:media)
    end
end
