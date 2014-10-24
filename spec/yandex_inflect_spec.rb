require File.dirname(__FILE__) + '/spec_helper.rb'

describe YandexInflect do
  before(:all) do
    @sample_inflection = ["рубин", "рубина", "рубину", "рубин", "рубином", "рубине"]
  end

  before(:each) do
    @inflection = double(:inflection)
    YandexInflect::clear_cache
  end

  it "should return an array of inflections when webservice returns an array" do
    allow(@inflection).to receive(:get) { @sample_inflection }
    expect(YandexInflect::Inflection).to receive(:new).and_return(@inflection)
    expect(YandexInflect.inflections("рубин")).to eq @sample_inflection
  end

  it "should return an array filled with identical strings when webservice returns a string" do
    allow(@inflection).to receive(:get) { "рубин1" }
    expect(YandexInflect::Inflection).to receive(:new).and_return(@inflection)
    expect(YandexInflect.inflections("рубин")).to eq %w(рубин1 рубин1 рубин1 рубин1 рубин1 рубин1)
  end

  it "should return an array filled with identical strings of original word when webservice does not return anything meaningful or throws an exception" do
    allow(@inflection).to receive(:get) { nil }
    expect(YandexInflect::Inflection).to receive(:new).and_return(@inflection)
    expect(YandexInflect.inflections("рубин")).to eq %w(рубин рубин рубин рубин рубин рубин)
  end
end

describe YandexInflect, "with caching" do
  before(:each) do
    @inflection = double(:inflection)
    YandexInflect::clear_cache
  end

  it "should cache successful lookups" do
    sample = ["рубин", "рубина", "рубину", "рубин", "рубином", "рубине"]
    allow(@inflection).to receive(:get) { sample }
    expect(YandexInflect::Inflection).to receive(:new).once.and_return(@inflection)

    2.times { YandexInflect.inflections("рубин") }
  end

  it "should NOT cache unseccussful lookups" do
    sample = nil
    allow(@inflection).to receive(:get) { sample }
    expect(YandexInflect::Inflection).to receive(:new).twice.and_return(@inflection)

    2.times { YandexInflect.inflections("рубин") }
  end

  it "should allow to clear cache" do
    sample = "рубин"
    allow(@inflection).to receive(:get) { sample }
    expect(YandexInflect::Inflection).to receive(:new).twice.and_return(@inflection)

    YandexInflect.inflections("рубин")
    YandexInflect.clear_cache
    YandexInflect.inflections("рубин")
  end
end

describe YandexInflect::Inflection do
  before(:all) do
    @sample_answer = {
      "inflections"=>{"inflection"=>["рубин", "рубина", "рубину", "рубин", "рубином", "рубине"], "original"=>"рубин"}
    }
    @sample_inflection = ["рубин", "рубина", "рубину", "рубин", "рубином", "рубине"]
  end

  it "should get inflections for a word" do
    allow(YandexInflect::Inflection).to receive(:get) { @sample_answer }
    expect(YandexInflect::Inflection.new.get("рубин")).to eq @sample_inflection
  end
end
