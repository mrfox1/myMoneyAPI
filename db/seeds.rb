if Rails.env.development?
  RECORD_TYPES = %w{Expense Income}

  10.times do
    User.create!(name: Faker::Name.name,
                 email: Faker::Internet.email,
                 password: Faker::Internet.password(min_length: 8))
  end

  user_ids = User.ids

  15.times do
    Category.create!(name: Faker::Commerce.product_name, record_type: RECORD_TYPES[rand(0..1)], user_id: user_ids.sample)
  end

  category_ids = Category.ids

  50.times do
    Expense.create!(sum: Faker::Number.decimal(l_digits: 2),
                    date: Faker::Date.in_date_period(year: 2020),
                    description: Faker::Lorem.paragraph,
                    category_id: category_ids.sample,
                    user_id: user_ids.sample)
  end

  50.times do
    Income.create!(sum: Faker::Number.decimal(l_digits: 2),
                   date: Faker::Date.in_date_period(year: 2020),
                   description: Faker::Lorem.paragraph,
                   category_id: category_ids.sample,
                   user_id: user_ids.sample)
  end
end
