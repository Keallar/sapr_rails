class PreprocessorController < ApplicationController
  before_action :set_construction!, only: %i[show update edit destroy]
  before_action :set_rods!, only: %i[show edit]
  after_action :processor_calculate, only: %i[update create]

  def index
    @constructions = Construction.all
  end

  def show; end

  def edit
    @rod = Rod.new
  end

  def update
    @construction.rods.destroy_all
    if @construction.update!(construction_params)
      flash.now[:success] = 'Construction updated!'
      redirect_to preprocessor_index_path
    else
      flash.now[:error] = 'Error!'
      render :edit
    end
  end

  def new
    @construction = Construction.new
  end

  def create
    ActiveRecord::Base.transaction do
      @construction = Construction.create(construction_params)
      rods = JSON.parse(params[:construction][:rods])
      created_rods = []
      rods.each do |rod|
        created_rods << Rod.create(
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
      redirect_to preprocessor_index_path, notice: 'Construction created!'
    end
  end

  def destroy
    @construction.destroy!
    redirect_to preprocessor_index_path
  end

  private

  def set_construction!
    @construction = Construction.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error e.message
    flash[:error] = 'Construction not found!'
    redirect_to preprocessor_index_path
  end

  def set_rods!
    @rods = @construction.rods.sort_by(&:place_id)
  end

  def construction_params
    params.require(:construction).permit(:name, :left_support, :right_support,
                                         rods_attributes: [:place_id, :l, :a, :e, :b, :f, :q])
  end

  def processor_calculate
    ConstructionService.new(@construction).perform
  rescue => e
    Rails.logger.error e.message
    flash[:error] = 'Something went wrong in calculate!'
  end
end
