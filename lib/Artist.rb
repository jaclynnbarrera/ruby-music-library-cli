require 'pry'

class Artist
    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []
    
    def initialize(name)
        @name = name
        @songs = []
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
        artist = Artist.new(name)
        artist.save
        artist
    end

    def add_song(new_song)
        new_song.artist = self if new_song.artist != self
        self.songs << new_song if self.songs.none? {|song|song == new_song}
    end

    # returns a collection of genres for all of the artist's songs
    def genres
        genres = []
        songs.each do |song|
            genres << song.genre
        end
        genres.uniq
    end
end