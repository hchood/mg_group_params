require 'csv'
require 'sinatra'

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

def get_artist(filename, name)
  artists = read_artists_from(filename)
  genre = artists[name][:genre]

  { name: name, genre: genre }
end


# [ {name: 'One', artist: 'U2'} ]
def get_songs_for(filename, artist_name)
  songs = []

  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    if row[:artist] == artist_name
      songs << row.to_hash
    end
  end

  songs
end

# GET '/artists'
get '/artists' do
  # create any variables we need to display in the view
  @artists = read_artists_from('artists.csv') # read in the artists from the artists csv

  # render the view
  erb :artists
end


# GET '/artists/U2'
get '/artists/:artist' do
  @artist = get_artist('artists.csv', params[:artist])
  @songs = get_songs_for('songs.csv', params[:artist])

  erb :artist
end
