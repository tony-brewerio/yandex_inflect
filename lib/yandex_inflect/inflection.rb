require 'httparty'

module YandexInflect
  class Inflection
    include HTTParty
    base_uri 'http://export.yandex.ru/'

    def get(name)
      options = {}
      options[:query] = {name: name}
      inflections = self.class.get('/inflect.xml', options)

      inflections['inflections']['inflection']
    end
  end
end
