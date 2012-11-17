class Translation
  DEFAULT_DOMAIN = 'en'

  def initialize
    @config = YAML.load_file config_path
  end

  def for(options = {})
    return options[:user].language if options[:user]

    if options[:domain]
      language = language_for_domain options[:domain]
      return language if language
    end
    return DEFAULT_DOMAIN
  end

  def self.for(options)
    instance.for options
  end

  def self.instance
    @instance ||= Translation.new
  end

  protected
  def language_for_domain(domain)
    @config[domain.gsub('www.', '')]
  end

  def config_path
    File.join Rails.root, 'config/translation_settings.yml'
  end
end