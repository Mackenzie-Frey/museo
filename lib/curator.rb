class Curator
  attr_reader :artists, :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  # def name
  #   binding.pry
  #   if object == photograph collection
  #     @photographs[0][:name]
  #   elsif object == artist collection
  #     @artists[0][:name]
  #   end
  # end

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
  end

end
