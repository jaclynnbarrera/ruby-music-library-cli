require 'pry'

class MusicLibraryController
    extend Concerns::Findable

    attr_accessor :song, :genre, :artist

    def initialize(path = './db/mp3s')
        MusicImporter.new(path).import
    end

    def call
        input = ""
        while input != "exit"
          puts "Welcome to your music library!"
          puts "To list all of your songs, enter 'list songs'."
          puts "To list all of the artists in your library, enter 'list artists'."
          puts "To list all of the genres in your library, enter 'list genres'."
          puts "To list all of the songs by a particular artist, enter 'list artist'."
          puts "To list all of the songs of a particular genre, enter 'list genre'."
          puts "To play a song, enter 'play song'."
          puts "To quit, type 'exit'."
          puts "What would you like to do?"
    
          input = gets.chomp
    
          case input
          when "list songs"
            list_songs
          when "list artists"
            list_artists
          when "list genres"
            list_genres
          when "list artist"
            list_songs_by_artist
          when "list genre"
            list_songs_by_genre
          when "play song"
            play_song
          end
        end
    end 

    def list_songs
        sorted = Song.all.sort_by {|song|song.name}
        sorted.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end 
    end 

    def list_artists
        sorted = Artist.all.sort_by {|artist|artist.name}
        sorted.each.with_index(1) do |artist,index|
            puts "#{index}. #{artist.name}"
        end 
    end

    def list_genres
        sorted = Genre.all.sort_by {|genre|genre.name}
        sorted.each.with_index(1) do |genre,index|
            puts "#{index}. #{genre.name}"
        end 
    end

    #list_songs_by_artist prints all songs by a particular artist in a numbered list (alphabetized by song name)
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        found = Song.all.find_all {|song| song.artist.name == input}
        sorted = found.sort_by {|song|song.name}
        sorted.each.with_index(1) do |song, index|
            puts "#{index}. #{song.name} - #{song.genre.name}"
        end 

    end

    # prints all songs by a particular genre in a numbered list (alphabetized by song name)
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        found = Song.all.find_all {|song| song.genre.name == input}
        sorted = found.sort_by {|song|song.name}
        sorted.each.with_index(1) do |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name}"
        end 
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
        sorted = Song.all.sort_by {|song|song.name}

        if input.between?(1, Song.all.count)
            input -= 1
            song_name = sorted[input].name
            song_artist = sorted[input].artist.name
            puts "Playing #{song_name} by #{song_artist}"
        end    
    end
end

