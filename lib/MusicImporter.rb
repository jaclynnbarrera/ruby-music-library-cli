require 'pry'

class MusicImporter
    attr_accessor :path, :song

    def initialize(filepath)
        @path = filepath
    end

    def files
        Dir.children(path)
    end

    def import
        files.each do |song|
            Song.create_from_filename(song)
        end
    end

end