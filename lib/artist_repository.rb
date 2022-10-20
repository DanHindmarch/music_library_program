require_relative 'artist'

class ArtistRepository
    def all
        sql = 'SELECT id, name, genre FROM artists;'
        result_set = DatabaseConnection.exec_params(sql,[])

        artists = []

        result_set.each do |x|
            artist = Artist.new
            artist.id = x['id']
            artist.name = x['name']
            artist.genre = x['genre']

            artists << artist
        end

        return artists
    end

    def find(id)
        sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
        params = [id]

        result_set = DatabaseConnection.exec_params(sql, params) 

        record = result_set[0]

        artist = Artist.new
        artist.id = record['id']
        artist.name = record['name']
        artist.genre = record['genre']

        return artist
      end

      def create(artist)
        sql = 'INSERT INTO artists (name, genre) VALUES($1, $2);'
        params = [artist.name, artist.genre]

        DatabaseConnection.exec_params(sql, params) 

        return nil
      end
end