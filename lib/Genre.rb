require 'pry'

class Genre
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
        genre = Genre.new(name)
        genre.save
        genre
    end

    # returns a collection of artists for all of the genre's songs (genre has many artists through songs)
    def artists
        artists = []
        songs.each do |song|
            artists << song.artist
        end
        artists.uniq
    end

end

