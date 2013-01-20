module Fql
  def self.access_token
    # TODO: Think about that!
    Settings.facebook.app_secret
  end

  def self.get(query)
    self.execute query, access_token: access_token
  end
end
