FactoryGirl.define do
  factory :item do
    sequence :title do |n|
      "title #{n}"
    end
    sequence :description do |n|
      "describe #{n}"
    end
    sequence :price do |n|
      n
    end
    sequence :image do |n|
      "img tag #{n}"
    end
  end

  factory :category do
    sequence :name do |n|
      "name#{n}"
    end
  end

end
