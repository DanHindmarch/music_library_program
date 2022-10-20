# file: app.rb
##require_relative 'lib/database_connection'
##require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
##DatabaseConnection.connect('music_library')

# Print out each record from the result set .
##albums = AlbumRepository.new
##albums.all.each do |album|
##  p "#{album.id} - #{album.title} - #{album.release_year}"
##end

#album = albums.find(3)
#p album.title
#p album.release_year
#p album.artist_id


# file: app.rb

require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative 'lib/database_connection'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input
    @io.puts 'Welcome to the music library manager!'
    @io.puts ''
    @io.puts 'What would you like to do?'
    @io.puts '1 - List all albums'
    @io.puts '2 - List all artists'
    @io.puts ''
    @io.puts 'Enter your choice:'
    choice = get_option
    @io.puts ''
    @io.puts check_choice(choice)
    if choice.to_i == 1
      @io.puts list_albums
    else
      @io.puts list_artists
    end
  end

  def album_information(album)
    return "#{album.id} - #{album.title} - #{album.release_year}"
  end

  def artist_information(artist)
    return "#{artist.id} - #{artist.name} - #{artist.genre}"
  end

  def get_option
    response = @io.gets
    return response if response.to_i == 1 || response.to_i == 2
    fail 'Error: You must choose option 1 or 2'
  end

  def welcome_message
    return 'Welcome'
  end

  def check_choice(choice)
    if choice.to_i == 1
      return 'Here is the list of albums:'
      else 
      return 'Here is the list of artists:'
    end
  end

    def list_albums
      albums = []
      @album_repository.all.each do |album|
        albums << album_information(album)
      end
      return albums
    end

    def list_artists
      artists = []
        @artist_repository.all.each do |artist|
        artists << artist_information(artist)
      end
      return artists
    end
  end
# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end

