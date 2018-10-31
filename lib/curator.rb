class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.map do |artist|
      if artist.id == id
        return artist
      end
    end
  end

  def find_photograph_by_id(id)
    @photographs.map do |photograph|
      if photograph.id.to_s == id
        return photograph
      end
    end
  end

  def find_photographs_by_artist(artist)
    specific_artist_collection = []
    @photographs.each do |photo|
      binding.pry
      # iterate through @artists to find the id that matches the photo id
      if @artists == photo.artist_id
        specific_artist_collection << photo
      end
    end
    specific_artist_collection
  end

end
