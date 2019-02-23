module DecksHelper
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
end
