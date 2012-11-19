require 'net/http'
require 'zlib'
require 'csv'

namespace :import do

  desc "Import cities"
  task localization: :environment do
    Net::HTTP.start("www.maxmind.com") do |http|
      puts "Fetching worldcitiespop.txt.gz..."
      resp = http.get("/download/worldcities/worldcitiespop.txt.gz")
      puts "Inflating..."
      gzipped = Zlib::GzipReader.new StringIO.new resp.body.to_s
      puts "Importing rows..."
      import_from gzipped.read.force_encoding('ISO-8859-1')
    end
  end

  def import_from(content, options={ country: 'br',
                                     population_greater_than: 1000 })
    if options[:country]
      puts "Filtering by country: #{options[:country]}..."
      header = content.lines.first
      content.gsub!(/^(?!#{options[:country]}).*\n/, '')
      content.prepend header
    end

    if options[:population_greater_than]
      puts "Filtering cities with population lower than #{
            options[:population_greater_than]}"
    end

    cities    = []
    CSV.parse content, headers: true do |row|
      country = find_or_create_country_for row
      next if options[:population_greater_than].nil? or
              options[:population_greater_than] > row['Population'].to_i
      city = City.new country_id: country.id,
                      name:       row['AccentCity'].encode('UTF-8'),
                      longitude:  row['Longitude'],
                      latitude:   row['Latitude'],
                      code:       row['City']
      cities.push city
      puts "City: #{city.inspect}"
    end

    puts "Importing #{cities.count} cities"
    City.import cities
    puts "Done!"
  end

  def find_or_create_country_for(row)
    country_code = row['Country']

    unless country = Country.where(code: country_code).first
      country = Country.create code: country_code
      puts "Country: #{country.inspect}"
    end

    country
  end

end
