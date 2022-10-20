require './app'

RSpec.describe Application do

    it 'returns a welcome string' do
        io = double :io
        new_app = Application.new('music_library', 'nothing', AlbumRepository.new, ArtistRepository.new)
        expect(new_app.welcome_message).to eq('Welcome')
    end

    it '#album_information - returns the id and album name' do
        new_app = Application.new('music_library', 'chdscn', AlbumRepository.new, ArtistRepository.new)
        album = double(:album, :id => 2, :title => 'Surfer Rosa', :release_year => 1989)
        expect(new_app.album_information(album)).to eq('2 - Surfer Rosa - 1989')
    end

    it '#artist_information - returns the id and artist name and genre' do
        new_app = Application.new('music_library', 'chdscn', AlbumRepository.new, ArtistRepository.new)
        artist = double(:artist, :id => 1, :name => 'ABBA', :genre => 'Pop')
        expect(new_app.artist_information(artist)).to eq('1 - ABBA - Pop')
    end

    it 'returns album message if argument is 1 and artist message if argument is 2  ' do
        new_app = Application.new('music_library', 'chdscn', AlbumRepository.new, ArtistRepository.new)
        expect(new_app.check_choice(1)).to eq('Here is the list of albums:')
        expect(new_app.check_choice(2)).to eq('Here is the list of artists:')
    end

    it 'returns first item in artists list' do
        new_app = Application.new('music_library', 'chdscn', AlbumRepository.new, ArtistRepository.new)
        expect(new_app.list_artists.first).to eq("1 - Pixies - Rock")
    end

    it 'returns first item in albums list' do
        new_app = Application.new('music_library', 'chdscn', AlbumRepository.new, ArtistRepository.new)
        expect(new_app.list_albums.first).to eq("1 - Doolittle - 1989")
    end

    it 'fails' do
        io = double :io
        new_app = Application.new('music_library', io, AlbumRepository.new, ArtistRepository.new)
        expect(io).to receive(:puts).with('Welcome to the music library manager!').ordered
        expect(io).to receive(:puts).with('').ordered
        expect(io).to receive(:puts).with('What would you like to do?').ordered
        expect(io).to receive(:puts).with('1 - List all albums').ordered
        expect(io).to receive(:puts).with('2 - List all artists').ordered
        expect(io).to receive(:puts).with('').ordered
        expect(io).to receive(:puts).with('Enter your choice:').ordered
        expect(io).to receive(:gets).and_return('3').ordered
        expect{new_app.run}.to raise_error 'Error: You must choose option 1 or 2'
    end

end