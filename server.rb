require 'csv'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'

# Create pages for:
# - Page that lists all the artists & links to artist's page
# - Page for each artist.  Has name, genre, and then name of each of their songs
# - Page that lists all songs
# - Page for each song, showing name of song & artist name

# ARRAY OF HASHES
# [
#   { name: 'U2' , genre: 'rock'},
#   { name: 'Empire of the Sun', genre: 'indie pop'}
# ]

# to retrieve U2:
# artists_array.each do |artist|
#   if artist[:name] == 'U2'
#     u2 = artist
#   end
# end

# HASH OF HASHES
# {
#   "U2" => {genre: 'rock'},
#   "Empire of the Sun" => {genre: 'indie pop'}
# }

# artists_hash["U2"]

def read_artists_from(filename)
  artists = {}

  CSV.foreach(filename, headers: true) do |row|
    artists[row['Name']] = { genre: row['Genre'] }
  end

  artists
end

get '/artists' do
  # create any variables we need to display in the view
  @artists = read_artists_from('artists.csv') # read in the artists from the artists csv

  # render the view
  erb :artists
end

# get '/:artist' do

# end
















