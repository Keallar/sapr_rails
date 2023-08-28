# frozen_string_literal: true

class PostprocessorController < ApplicationController
  before_action :set_construction!, only: %i[show]
  before_action :set_rods!, only: %i[show]

  def index
    @constructions = Construction.all
  end

  def show; end

  private

  def set_construction!
    @construction = Construction.find(params[:id])
  end

  def set_rods!
    @rods = @construction.rods
  end
end
