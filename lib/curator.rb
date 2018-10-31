class Curator
  attr_reader :artists, :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def name
    binding.pry
    if
      @photographs[0][:name]
    elsif
      @artists[0][:name]
    end
  end

  def add_artist(artist)
    @artists << artist
  end

end
