# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.all.each(&:destroy)

default_user = User.new(
  name: 'Cool Guy',
  email: 'coolguy@email.com',
  password: 'password',
  birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
  bio: Faker::Movies::HarryPotter.quote,
  food: Faker::Food.dish,
  animal: Faker::Creature::Animal.name,
  color: Faker::Color.color_name
)

default_user.skip_confirmation!
default_user.save

default_user.photo.attach(io: File.open("app/assets/images/dog-allergies.webp"), filename: "something")

15.times do
  user = User.new(
    name: Faker::FunnyName.unique.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8),
    birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
    bio: Faker::Movies::HarryPotter.quote,
    food: Faker::Food.dish,
    animal: Faker::Creature::Animal.name,
    color: Faker::Color.color_name
  )

  user.skip_confirmation!
  user.save

  user.photo.attach(io: File.open("app/assets/images/default-non-user-no-photo-1.jpg"), filename: "something")
end

User.all.each do |user|
  rand(4).times do
    post = user.posts.build(body: Faker::Lorem.paragraph(sentence_count: rand(5..20), supplemental: true, random_sentences_to_add: 4),
                            created_at: Faker::Time.backward(days: 30))
    post.save
  end
end

User.all.each do |user|
  next if user == default_user

  rand(8).times do
    like = user.likes.build(post_id: Post.all.sample.id)
    like.save
  end
end

User.all.each do |user|
  next if user == default_user

  rand(8).times do
    comment = user.comments.build(post_id: Post.all.sample.id,
                                  body: Faker::Lorem.sentence(word_count: 6, supplemental: true, random_words_to_add: 4),
                                  created_at: Faker::Time.backward(days: 20))
    comment.save
  end
end

User.all.each do |user|
  next if user == default_user

  friendship = user.friendships.build(friend_id: default_user.id)
  friendship.save
end
