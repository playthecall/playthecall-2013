require 'net/http'
require 'zlib'
require 'csv'

namespace :import do

  desc "Import cities"
  task :cities, [:country_code, :population] => :environment do |t, args|
      country_code = args[:country_code]
      population = args[:population] || 1000
      puts "Inflating db/resources/worldcitiespop.txt.gz..."
      seed_file = File.open "db/resources/worldcitiespop.txt.gz"
      gzipped_file = Zlib::GzipReader.new seed_file
      puts "Importing rows..."
      import_from(gzipped_file.read.
                               force_encoding('ISO-8859-1').
                               encode('UTF-8'), {:country => country_code,
                                                 :population_greater_than => population})
  end

  def import_from(content, options)
    if options[:country]
      puts "Filtering by country: #{options[:country]}..."
      header = content.lines.first
      content.gsub!(/^(?!#{options[:country]}).*\n/, '')
      content.prepend header
    end

    content.gsub!(/\"/,' ')

    if options[:population_greater_than]
      puts "Filtering cities with population lower than #{
            options[:population_greater_than]}"
    end

    cities    = []
    CSV.parse content, headers: true do |row|
      begin
        country = find_or_create_country_for row
        next if options[:population_greater_than].nil? or
          options[:population_greater_than] > row['Population'].to_i
        City.create country_id: country.id,
          name:       row['AccentCity'],
          longitude:  row['Longitude'],
          latitude:   row['Latitude'],
          code:       row['City']
      rescue => exception
        p exception.message
      end
    end

    puts "Importing #{City.count} cities"
    puts "Done!"
  end

  def find_or_create_country_for(row)
    country_code = row['Country']
    Country.find_or_create_by_code(country_code)
  end

end
