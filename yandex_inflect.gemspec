$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'yandex_inflect/version'

Gem::Specification.new do |s|
  s.name = 'yandex_inflect'
  s.version = YandexInflect::VERSION

  s.authors = ['Ярослав Маркин', 'Shum']
  s.email = ['yaroslav@markin.net', 'schumi@live.ru']
  s.extra_rdoc_files = ['README.rdoc', 'MIT-LICENSE']
  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.require_paths = ['lib']

  s.summary = 'Yandex.Inflect webservice client, provides Russian language pluralization'

  s.add_dependency 'httparty'

  s.add_development_dependency 'rspec', '~> 2.7.0'
end
