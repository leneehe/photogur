class PicturesController < ApplicationController
  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: %i(show edit update destroy)
  before_action :ensure_user_owns_picture, only: %i(show edit update destroy)
  def index
    @pictures = Picture.all

    last_month = DateTime.current.prev_month
    @old_pictures = Picture.created_before(last_month)

    @years = Picture.years_created
    @all_year_pictures = {}
    @years.each do |year|
      year_pictures = Picture.pictures_created_in_year(year)
      @all_year_pictures[year] = year_pictures
    end

  end

  def show
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = current_user.id

    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures" (the index)
      redirect_to "/pictures"
    else
      # otherwise render new.html.erb
      render :new
    end
    # render text: "Received POST request to '/pictures' with the data URL: #{params}"
  end

  def edit
  end

  def update

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to '/pictures'
  end

  private
  def load_picture
    @picture = Picture.find(params[:id])
  end

end
