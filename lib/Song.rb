require 'pry'

class Song
    
    attr_accessor :name, :MusicLibraryController
    attr_reader :artist, :genre

    @@all = []
    
    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist) if artist!=nil
        self.genre=(genre) if genre!=nil
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    #passings an artist to the song
    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    # adds the song to the genre's collection of songs
    def genre=(genre)
        @genre = genre
        genre.songs << self if genre.songs.none? {|song|song == self}
    end

    # finds a song instance in @@all by the name property of the song
    def self.find_by_name(song_name)
        all.find {|song|song.name == song_name}
    end

    def self.find_or_create_by_name(song_name)
        find_by_name(song_name) || create(song_name)
    end 

    def self.new_from_filename(filename)
        song_name = filename.split(" - ")[1]
        artist_name = filename.split(" - ")[0]
        genre_name = filename.split(" - ")[2].delete_suffix('.mp3') 

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        new(song_name,artist,genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end
  
end

