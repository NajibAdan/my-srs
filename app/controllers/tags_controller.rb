# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    @tags = current_user.tags.all
  end

  def show
    @tag = current_user.tags.find_by(id: params[:id])
  end
end
