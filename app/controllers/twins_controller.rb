class TwinsController < ApplicationController
  def index
    @twin = Twin.all
  end

  def show
    @twin = Twin.find(params[:id])
    @tags = @twin.tags
    @tag = Tag.new
    # @tags << @tag
    # @twin.tags.clear
    # tags = params[:twin][:tag_ids]
    # tags.each do |tag_id|
    #  @twin.tags << Tag.find(tag_id) unless tag_id.blank?
    # end
    # if @twin.update(twin_params)
    #   redirect_to @twin
    # else
    #   render 'edit'
    # end
    # redirect_to twin_path

  end

  def new
    @twin = Twin.new
    @tags = Tag.all
  end

  def edit
    @twin = Twin.find(params[:id])
    @tags = Tag.all
  end

  def create
    @twin = Twin.new(twin_params)

    tags = params[:twin][:tag_ids]
    tags.each do |tag_id|
     @twin.tags << Tag.find(tag_id) unless tag_id.blank?
    end
    if @twin.save
      redirect_to @twin
    else
      render 'new'
    end
  end

  def update
    @twin = Twin.find(params[:id])
    @twin.tags.clear
    tags = params[:twin][:tag_ids]
    tags.each do |tag_id|
     @twin.tags << Tag.find(tag_id) unless tag_id.blank?
    end
    if @twin.update(twin_params)
      redirect_to @twin
    else
      render 'edit'
    end
  end
    private
    def twin_params
      params.require(:twin).permit(:name, :position, :number, :bio)
    end
    # def tag_params
    #   params.require(:tag).permit(:name)
    # end
end
