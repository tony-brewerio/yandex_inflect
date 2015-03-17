require 'yandex_inflect/inflection'

module YandexInflect
  INFLECTIONS_COUNT = 6

  @cache = {}

  # Возвращает массив склонений
  #
  # Если слово не найдено в словаре, будет возвращен массив размерностью INFLECTIONS_COUNT,
  # заполненный этим словом.
  def self.inflections(word)
    inflections = []

    lookup = cache_lookup(word)
    return lookup if lookup

    get = Inflection.new.get(word) rescue nil

    case get
    when Hash then
      # Cлово не найдено в словаре, забиваем оригиналом весь массив.
      inflections.fill(word, 0..INFLECTIONS_COUNT - 1)
      cache_store(word, inflections)
    when Array then
      get.each { |h| inflections[h['case'].to_i - 1] = h['__content__'] }
      cache_store(word, inflections)
    else
      inflections.fill(word, 0..INFLECTIONS_COUNT - 1)
    end

    inflections
  end

  def self.clear_cache
    @cache.clear
  end

  private

  def self.cache_lookup(word)
    @cache[word.to_s]
  end

  def self.cache_store(word, value)
    @cache[word.to_s] = value
  end
end
