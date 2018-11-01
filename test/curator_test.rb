require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'
require 'CSV'
require 'pry'

class CuratorTest < Minitest::Test

  def test_it_exists
    curator = Curator.new
    assert_instance_of Curator, curator
  end

  def test_it_has_artist_and_photograph_collections
    curator = Curator.new
    assert_equal [], curator.artists
    assert_equal [], curator.photographs
  end

  def test_it_can_add_photos
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    assert_equal [photo_1, photo_2], curator.photographs
  end

  def test_it_knows_photo_order_and_attributes
    curator = Curator.new
    attributes_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    attributes_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_1 = Photograph.new(attributes_1)
    photo_2 = Photograph.new(attributes_2)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    assert_equal photo_1, curator.photographs.first
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", curator.photographs.first.name
  end

  def test_it_has_artists
    curator = Curator.new
    attributes_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    attributes_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_1 = Artist.new(attributes_1)
    artist_2 = Artist.new(attributes_2)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    assert_equal [artist_1, artist_2], curator.artists
    assert_equal artist_1, curator.artists.first
    assert_equal "Henri Cartier-Bresson", curator.artists.first.name
  end

  def test_it_can_find_artists_by_id
    curator = Curator.new
    attributes_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    attributes_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_1 = Artist.new(attributes_1)
    artist_2 = Artist.new(attributes_2)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    assert_equal artist_1, curator.find_artist_by_id("1")
  end

  def test_it_can_find_photographs_by_id
    curator = Curator.new
    attributes_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    attributes_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_1 = Photograph.new(attributes_1)
    photo_2 = Photograph.new(attributes_2)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    assert_equal photo_2, curator.find_photograph_by_id("2")
  end

  def test_it_finds_artist_by_id
    attributes_1_photo = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    attributes_2_photo = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    attributes_3_photo = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    attributes_4_photo = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    attributes_1_artist = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    attributes_2_artist = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    attributes_3_artist = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    photo_1 = Photograph.new(attributes_1_photo)
    photo_2 = Photograph.new(attributes_2_photo)
    photo_3 = Photograph.new(attributes_3_photo)
    photo_4 = Photograph.new(attributes_4_photo)
    artist_1 = Artist.new(attributes_1_artist)
    artist_2 = Artist.new(attributes_2_artist)
    artist_3 = Artist.new(attributes_3_artist)
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")
    assert_equal artist_3, diane_arbus
  end

  def test_it_finds_photographs_by_artist
    attributes_1_photo = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    attributes_2_photo = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    attributes_3_photo = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    attributes_4_photo = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    attributes_1_artist = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    attributes_2_artist = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    attributes_3_artist = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    photo_1 = Photograph.new(attributes_1_photo)
    photo_2 = Photograph.new(attributes_2_photo)
    photo_3 = Photograph.new(attributes_3_photo)
    photo_4 = Photograph.new(attributes_4_photo)
    artist_1 = Artist.new(attributes_1_artist)
    artist_2 = Artist.new(attributes_2_artist)
    artist_3 = Artist.new(attributes_3_artist)
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")
    assert_equal [photo_3, photo_4], curator.find_photographs_by_artist(diane_arbus)
  end

  def test_it_finds_artists_with_multiple_photographs
    attributes_1_photo = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    attributes_2_photo = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    attributes_3_photo = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    attributes_4_photo = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    attributes_1_artist = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    attributes_2_artist = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    attributes_3_artist = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    photo_1 = Photograph.new(attributes_1_photo)
    photo_2 = Photograph.new(attributes_2_photo)
    photo_3 = Photograph.new(attributes_3_photo)
    photo_4 = Photograph.new(attributes_4_photo)
    artist_1 = Artist.new(attributes_1_artist)
    artist_2 = Artist.new(attributes_2_artist)
    artist_3 = Artist.new(attributes_3_artist)
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")
    assert_equal [artist_3], curator.artists_with_multiple_photographs
    assert_equal 1, curator.artists_with_multiple_photographs.length
    assert_equal true, diane_arbus == curator.artists_with_multiple_photographs.first
  end

  def test_it_photographs_taken_by_artists_from
    attributes_1_photo = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    attributes_2_photo = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    attributes_3_photo = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    attributes_4_photo = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    attributes_1_artist = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    attributes_2_artist = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    attributes_3_artist = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    photo_1 = Photograph.new(attributes_1_photo)
    photo_2 = Photograph.new(attributes_2_photo)
    photo_3 = Photograph.new(attributes_3_photo)
    photo_4 = Photograph.new(attributes_4_photo)
    artist_1 = Artist.new(attributes_1_artist)
    artist_2 = Artist.new(attributes_2_artist)
    artist_3 = Artist.new(attributes_3_artist)
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    assert_equal [photo_2, photo_3, photo_4], curator.photographs_taken_by_artists_from("United States")
    assert_equal [], curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_can_load_photographs
skip
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    assert_equal 4, @photographs.count
  end

  def test_load_artists
skip
    curator = Curator.new
    curator.load_artists('./data/artists.csv')
    assert_equal 3, @artists.count
  end

  def test_it_can_load_photo_year_range
skip
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    actual = curator.photographs_taken_between(1950..1965)
    assert_equal [photo, photo], actual
    #how to name the objects in the above photos
  end

  def test_it_collects_artist_age_with_photo_name
skip
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')
    diane_arbus = curator.find_artist_by_id("3")
    curator.artists_photographs_by_age(diane_arbus)
    assert_equal ({44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"})
  end
end
