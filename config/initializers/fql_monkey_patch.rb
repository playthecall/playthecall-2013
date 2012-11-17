module Fql
  def self.access_token
    Settings.facebook.defalt_access_token
  end

  def self.get(query)
    self.execute query, access_token: access_token
  end
end