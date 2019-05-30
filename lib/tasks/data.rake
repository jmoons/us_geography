namespace :data do
  desc "Parses and populates database with State/County/City Data"
  task generate_db_data: :environment do
    # City|State short|State full|County|City alias
      CITY_INDEX                = 0
      STATE_ABBREVIATION_INDEX  = 1
      STATE_FULL_INDEX          = 2
      COUNTY_INDEX              = 3

    File.open("lib/seed_data/us_cities_states_counties.csv", "r").each_with_index do |line, index|
      # Read the line and split
      # Find or create state, then county, then city
      split_string = line.split(/\|/)

      state   = State.create_with(abbreviation: split_string[STATE_ABBREVIATION_INDEX].upcase).find_or_create_by(name: split_string[STATE_FULL_INDEX].titleize)
      puts "Unable to create state (line: #{index + 1}, name: #{split_string[STATE_FULL_INDEX].titleize}) - errors: #{state.errors.messages.inspect}" unless state.valid?
      county  = County.find_or_create_by(name: split_string[COUNTY_INDEX].titleize, state: state)
      puts "Unable to create county (line: #{index + 1}, name: #{split_string[COUNTY_INDEX].titleize}): errors: #{county.errors.messages.inspect}" unless county.valid?
      city    = City.find_or_create_by(name: split_string[CITY_INDEX].titleize, county: county, state: state)
      puts "Unable to create city (line: #{index + 1}, name: #{split_string[CITY_INDEX].titleize}): errors: #{city.errors.messages.inspect}" unless city.valid?

    end
  end

end
