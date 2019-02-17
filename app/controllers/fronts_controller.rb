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
            redirect_to action: "new", card_id: card.id
        end
    end

    def edit
        @front = Front.find(params[:id])
    end

    def update
        @front = Front.find(params[:id])
        @front.media.purge
        if @front.update_attributes(front_params)
            flash[:success] = 'Front updated!'
            redirect_to @front.card
        else
            render 'edit'
        end
    end

    def destroy 
        @front = Front.find(params[:id])
        if @front.destroy
            flash[:success] = "Front destroyed"
            redirect_to @front.card
        end
    end
    private
    def front_params
        params.require(:front).permit(:text_field,:media)
    end
end
