class Translation
  DEFAULT_DOMAIN = 'en'

  def initialize
    @config = YAML.load_file config_path
  end

  def for(options = {})
    language_for_user(options[:user])     ||
    language_for_domain(options[:domain]) ||
    DEFAULT_DOMAIN
  end

  def language_for_user(user)
    user && user.language
  end

  def language_for_domain(domain)
    domain && @config[domain.gsub('www.', '')]
  end

  def self.for(options)
    instance.for options
  end

  def self.instance
    @instance ||= Translation.new
  end

  protected
  def config_path
    File.join Rails.root, 'config/translation_settings.yml'
  end
end