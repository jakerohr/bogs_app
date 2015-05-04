# class SearchController < ApplicationController
#   require 'typhoeus'
#   require 'awesome_print'
#   def new
#     @search = Twin.new
#   end

#   def create
#     request = Typhoeus::Request.new(
#       "http://api.sportradar.us/mlb-t5/league/full_rosters.json?api_key=vds9pgn7t9xngzbbrnmg66zb",
#       method: :get,
#       )
#     user_player = "Jordan Zimmermann"
#     response = request.run
#     data = JSON.parse(response.body)["teams"]
#     data.each do |i|
#      i["players"].each do |p|
#         if p["full_name"] == player
#         number = p["jersey_number"]
#         position = p["position"]
#         player = user_player
#         new_player = true
#         end
#       end
#     end

#     if new_player
#       @search = Twin.new(name: player, position: position, number: number)
#     else
#       flash[:info] = "Player not found."
#     end
#   end

#   private
#     def method_name

#     end
#     def twin_params
#       params.require(:twin).permit(:name, :position, :number, :bio)
#     end
# end



