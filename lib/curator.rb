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

  def find_artist_by_id(id)
    @artists.map do |artist|
      if artist.id == id
        return artist
      end
    end
  end

  def find_photographs_by_artist(artist)
    specific_artist_photos = []
    @photographs.each do |photo|
      if photo.artist_id == find_artist_by_id(artist.id).id
        specific_artist_photos << photo
      end
    end
    specific_artist_photos
  end

  def artists_with_multiple_photographs
    artist_with_multiple = []
    @artists.each do |artist|
      if find_photographs_by_artist(artist).count > 1
        artist_with_multiple << artist
      end
    end
    artist_with_multiple
  end

end
