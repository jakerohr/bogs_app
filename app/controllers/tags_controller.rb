class TagsController < ApplicationController
  def index
    @tags = Tag.all
    @twins = Twin.all
    @tag = Tag.new
  end
  def show
    @tag = Tag.find(params[:id])
    @twins = @tag.twins
  end
  def new
  end

  def create
    @tag = Tag.create(tag_params)
    redirect_to tags_path
    # if @tag.save
    #   render 'index'
    # else
    #   render 'root_path'
    # end
  end

  def destroy
     @tag = Tag.find(params[:id])

    unless @tag.twins.length > 0
      Tag.destroy(params[:id])
    else
      flash[:info] = "Cannot delete this tag. This tag belongs to #{@tag.twins.length} " + "Player".pluralize(@tag.twins.length)
    end

    redirect_to tags_path
  end
  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
