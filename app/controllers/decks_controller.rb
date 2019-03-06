# frozen_string_literal: true

class DecksController < ApplicationController
  include DecksHelper
  before_action :authenticate_user!
  before_action :correct_user, only: %i[destroy edit]
  def new
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.build(
      option: Option.find_by(id: deck_params[:option]),
      name: deck_params[:name],
      description: deck_params[:description]
    )
    if @deck.save
      flash[:success] = 'Deck created!'
      redirect_to decks_url
    else
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
      render 'edit'
    end
  end

  def show
    @deck = current_user.decks.find(params[:id])
    @study = @deck.study
  end

  def index
    @decks = current_user.decks.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @deck = Deck.find(params[:id])
    if @deck.destroy
      flash[:success] = 'Deck destroyed!'
      redirect_to action: 'index'
    else
      flash[:alert] = 'An error occured when deleting'
      redirect_to root_url
    end
  end

  def study
    @card = Deck.find(params[:id]).study.first
  end

  def study_receiver
    Card.find(params['card']['card_id']).set_interval(params['commit'].downcase)
    redirect_to action: 'study', id: params['card']['deck_id']
  end
end
