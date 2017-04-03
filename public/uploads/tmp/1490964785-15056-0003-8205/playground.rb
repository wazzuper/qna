@city_names = {
  new_york: 646,
  washington: 202,
  los_angeles: 310,
  san_francisco: 415,
  seattle: 206,
  miami: 786,
  alabama: 205,
  nashville: 615,
  atlanta: 404,
  memphis: 901
}

def show_city_names
  puts "Cities:"
  @city_names.each { |city, code| puts city }
end

show_city_names