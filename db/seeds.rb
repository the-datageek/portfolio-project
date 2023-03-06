# resetting your db
# bundle exec rake db:reset
# setting our faker details so that our db can be populated with seed dummy data
puts "Seeding data..."
# Erases previous records
puts "Deleting old data..."
Project.destroy_all
User.destroy_all
Skill.destroy_all
10.times do

    user = User.create(
        "name": Faker::Name.name,
        "email": Faker::Internet.email,
        "password_hash": Faker::Alphanumeric.alphanumeric(number: 10),
        # "prof_pic_url": Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "bmp"),
        # "phone_number": Faker::PhoneNumber.cell_phone,
        # "zip_address": Faker::Address.full_address,
        # "country": Faker::Address.country,
        # "profession": Faker::Job.title,
        # "education": Faker::Job.education_level,
        # "experience": rand(2..4),
    #   "createdAt": rand(3..4)

  )
  rand(1..6).times do
      Project.create(
      "title": Faker::Marketing.buzzwords,
      "description": Faker::Lorem.sentence,
      "user_id": user.id,
      "status": rand(0..3),
      "createdAt": rand(3..4)
  )
  end

  rand(1..5).times do
      Skill.create(
      "name": Faker::Job.key_skill,
      "user_id": user.id,
      "createdAt": rand(3..4)

      )
end
end
puts "Seeding data completed..."