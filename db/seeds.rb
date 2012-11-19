game_versions = [
  { name: 'Brasil', language: 'pt-BR'},
  { name: 'Global', language: 'en'   },
  { name: 'USA',    language: 'us'   },
  { name: 'China',  language: 'cn'   },
  { name: 'India',  language: 'in'   }
]

game_versions.each do |params|
  GameVersion.create params
end