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

  sequence :name do |n|
    "name#{n}"
  end

  factory :category do
    name

    sequence :slug do |n|
      "name#{n}"
    end
    
    factory :item_on_category do
      items {create_list(:item, 2)}
    end
  end

  factory :user do
    name
    sequence :email do |n|
      "email#{n}"
    end
    password "password"
  end

end
