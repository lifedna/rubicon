FactoryGirl.define do

  factory :web_app do
    git_name      'something.git'
    name          Forgery(:name).first_name
    url           Forgery(:internet).domain_name
    aka           ['bob', 'jane']
    note          Forgery(:lorem_ipsum).words(50)
  end

end
