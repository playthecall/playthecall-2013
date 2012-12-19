require 'csv'

namespace :import do
  desc "Import countries"
  task :countries => :environment do
    Country.delete_all
    File.open('./db/resources/countries.txt', 'r') do |file|
      count = 0
      while (line = file.gets)
        count += 1
        next if count == 1
        name, code = line.chomp.split(';')
        Country.create(:name => name.titleize, :code => code)
      end
    end
  end
end
