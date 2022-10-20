require 'album_repository'

RSpec.describe AlbumRepository do

    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end
    before(:each) do 
        reset_albums_table
    end

    it 'returns a list of albums' do
        repo = AlbumRepository.new
        albums = repo.all
        expect(albums.length).to eq(2)
        expect(albums.first.id).to eq('1')
        expect(albums.first.title).to eq('Wonderwall')
    end

    it 'returns Wonderwall from selecting the id ' do
        repo = AlbumRepository.new
        album = repo.find(1)
        expect(album.title).to eq('Wonderwall')
        expect(album.release_year).to eq ('1995')
    end

    it 'returns Wonderwall from selecting the id ' do
        repo = AlbumRepository.new
        album = repo.find(2)
        expect(album.title).to eq('Champagne Supernova')
        expect(album.release_year).to eq ('1998')
    end

    it 'returns Wonderwall from selecting the id ' do
        repo = AlbumRepository.new
        album = Album.new
        album.title = 'Trompe le Monde'
        album.release_year = 1991
        album.artist_id = 1

        repo.create(album)
        all_albums = repo.all
        last_album = all_albums.last
        expect(repo.create(album)).to eq nil
        expect(last_album.title).to eq 'Trompe le Monde'
    end
end