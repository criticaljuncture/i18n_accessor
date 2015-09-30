require 'active_hash'
require 'i18n_accessor'

class Grade < ActiveHash::Base
  include I18nAccessor

  i18n_accessor :name, key: 'name'

  i18n_accessor :long_abbreviation, scope: 'long'
  i18n_accessor :short_abbreviation, scope: 'short'

  self.data = [
    {id: 0, identifier: :kindergarten},
    {id: 1, identifier: :first},
    {id: 2, identifier: :second}
  ]
end

class Product
  include I18nAccessor

  i18n_accessor :name
  i18n_accessor :short_category, key: "category", scope: "short"
  i18n_accessor :long_category, key: "category", scope: "long"
end

describe "I18nAccessor" do
  before(:all) do
    I18n.load_path = ["spec/fixtures/locales/en.yml"]
    I18n.locale = 'en'
  end

  describe "#i18n_accessor" do
    let(:product) { Product.new }

    it "returns the proper i18n string for a simple usage" do
      expect(product.name).to eql( I18n.t('product.name') )
    end

    it "returns the proper i18n string for complex usage" do
      expect(product.short_category).to eql(
        I18n.t('product.category.short')
      )

      expect(product.long_category).to eql(
        I18n.t('product.category.long')
      )
    end
  end

  describe "#i18n_accessor with Active Hash" do
    let(:grade) { Grade.first }

    it "returns the proper i18n string for a simple usage" do
      expect(grade.name).to eql( I18n.t('grade.name') )
    end

    it "returns the proper i18n string for complex usage" do
      expect(grade.long_abbreviation).to eql("Kindergarten")

      expect(grade.short_abbreviation).to eql("K")
    end
  end
end
