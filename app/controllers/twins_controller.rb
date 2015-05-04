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
     request = Typhoeus::Request.new(
      "http://api.sportradar.us/mlb-t5/league/full_rosters.json?api_key=#{ENV['API_KEY']}",
      method: :get,
      )
    @twin = params.require(:twin)
    @new_player = false
    user_player = @twin["name"]
    response = request.run
    data = JSON.parse(response.body)["teams"]
    data.each do |i|
     i["players"].each do |p|
        if p["full_name"] == user_player
        @number = p["jersey_number"]
        @position = p["position"]
        @player = p["full_name"]
        @new_player = true

        end
      end
    end

    if @new_player == true
      @twin = Twin.new(name: @player, position: @position, number: @number)
      # redirect_to @twin
    else
      # flash[:info] = "Player not found."
      # render 'new'


      @twin = Twin.new(twin_params)

      tags = params[:twin][:tag_ids]
      tags.each do |tag_id|
       @twin.tags << Tag.find(tag_id) unless tag_id.blank?
      end
    end
      if @twin.save
        redirect_to @twin
      else
        render'new'
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
