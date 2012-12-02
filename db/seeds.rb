# encoding: utf-8

game_versions = [
  [{ name: 'Brasil', language: 'pt-BR'}, { name: 'Capítulo I - Despertar' }],
  [{ name: 'Global', language: 'en'   }, { name: 'Chapter I - Awakening'  }],
  [{ name: 'USA',    language: 'us'   }, { name: 'Chapter I - Awakening'  }],
  [{ name: 'China',  language: 'cn'   }, { name: 'Nissim I - Miojo'       }],
  [{ name: 'India',  language: 'in'   }, { name: 'Hare I - Krisha Hare!'  }]
]

game_versions.each do |game_params, chapter_params|
  n = 1
  version = GameVersion.create game_params
  chapter = version.chapters.create chapter_params
  FactoryGirl.create :mission, slug: "missions-#{n}", chapter: chapter
  n += 1
end