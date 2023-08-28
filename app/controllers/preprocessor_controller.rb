#frozen_string_literal: true

class PreprocessorController < ApplicationController
  before_action :set_construction!, only: %i[show update edit destroy]
  before_action :set_rods!, only: %i[show edit]
  after_action :processor_calculate, only: %i[update create]

  def index
    @constructions = Construction.all
  end

  def show; end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @construction.rods.destroy_all
      @construction.update!(construction_params)
      rods = JSON.parse(params[:construction][:rods])
      created_rods = rods.each_with_object([]) do |rod, cr_rods|
        cr_rods << Rod.create(
          place_id: rod['place_id'],
          l: rod['l'].to_i,
          a: rod['a'].to_i,
          e: rod['e'].to_i,
          b: rod['b'].to_i,
          f: rod['f'].to_i,
          q: rod['q'].to_i
        )
      end
      @construction.update!(
        rods: created_rods
      )
    end
  end

  def new
    @construction = Construction.new
  end

  def create
    @construction = Construction.create(construction_params)
    rods = JSON.parse(params[:construction][:rods])
    created_rods = rods.each_with_object([]) do |rod, cr_rods|
      cr_rods << Rod.create(
           place_id: rod['place_id'].to_i,
           l: rod['l'].to_i,
           a: rod['a'].to_i,
           e: rod['e'].to_i,
           b: rod['b'].to_i,
           f: rod['f'].to_i,
           q: rod['q'].to_i
         )
    end
    @construction.update!(
      rods: created_rods
    )
    redirect_to preprocessor_index_path
  end

  def destroy
    @construction.destroy!
    redirect_to preprocessor_index_path
  end

  private

  def set_construction!
    @construction = Construction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to preprocessor_index_path
  end

  def set_rods!
    @rods = @construction.rods
  end

  def construction_params
    params.require(:construction).permit(:name, :left_support, :right_support, rods: [:place_id, :l, :a, :e, :b, :f, :q])
  end

  def processor_calculate
    ConstructionService.perform(@construction)
  end
end
