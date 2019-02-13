module CardsHelper
    private 
    def card_params
        params.require(:card).permit(:tag_list)
    end
    def front_params
        params.require(:fronts_attributes).permit(:text_field,:media)
    end

    def back_params
        params.require(:backs_attributes).permit(:text_field,:media)
    end
    def correct_user 
        @card = current_user.decks.find_by(id: params[:deck])
        if @card.nil?
            flash[:notice] = "Unauthorised action!"
            redirect_to user_session_url 
        end
    end
end
