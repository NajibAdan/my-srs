class OptionsController < ApplicationController
    before_action :authenticate_user!
    def index
        @options = current_user.options.all
    end 
    def new
        @option = Option.new
    end
    def create 
        @option = current_user.options.new(option_params)
        if @option.save 
            flash[:success] = "Options created!"
            redirect_to options_url
        else
            flash.now[:notice] = 'SOMETHING WRONG HAS HAPPENED'
            render 'new'
        end
    end
    
     
    def destroy
        @option = Option.find(params[:id])
        if @option.destroy
            flash[:success] = "Options successfully deleted!"
            redirect_to options_url
        end
    end
    private 
    def option_params
        params.require(:option).permit(:name,:easyBonus,:newInterval,:intervalModifier)
    end
end
