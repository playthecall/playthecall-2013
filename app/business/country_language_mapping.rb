class CountryLanguageMapping
  def initialize
    @map = YAML.load_file config_path
  end

  def map(country_code)
    @map[country_code.downcase.to_sym] || default_map
  end

  def self.language_for_country(country_code)
   instance.map(country_code)[:default_language]
  end

  def self.version_for_country(country_code)
    GameVersion.find_by_name instance.map(country_code)[:version_name]
  end

  def self.instance
    @instance ||= CountryLanguageMapping.new
  end

  protected
  def config_path
    File.join Rails.root, 'config/country_mapping.yml'
  end

  def default_map
    {
      default_language: 'en',
      version_name:     'Global'
    }
  end
end