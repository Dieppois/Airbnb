user = User.create!({
  email: "test@gmail.com",
  password: "azerty",
})

6.times do |i|
  property = Property.create!({
    name: Faker::Lorem.unique.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 10),
    headline: Faker::Lorem.unique.sentence(word_count: 6),
    adress_1: Faker::Address.street_address,
    adress_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    price: Money.from_amount((50..100).to_a.sample, 'USD'),
  })

  property.images.attach(io: File.open("db/images/Property_#{i + 1}.png"), filename: property.name)
  property.images.attach(io: File.open("db/images/Property_#{i + 7}.png"), filename: property.name)

  (5..10).to_a.sample.times do
    Review.create!({
      content: Faker::Lorem.paragraph(sentence_count: 10),
      cleanliness_rating: (1..5).to_a.sample,
      communication_rating: (1..5).to_a.sample,
      checkin_rating: (1..5).to_a.sample,
      value_rating: (1..5).to_a.sample,
      location_rating: (1..5).to_a.sample,
      accuracy_rating: (1..5).to_a.sample,
      property: property,
      user: user
    })
  end
end
