unless Rails.env.production?
  namespace :dev do

    desc "Drops, creates, migrates, and adds sample data to database"
    task reset: [
      :environment,
      "db:drop",
      "db:create",
      "db:migrate",
      "dev:sample_data"
    ]
    
    desc "Adds sample data for development environment"
    task sample_data: [
      :environment, 
      "dev:add_users",
      "dev:add_memories",
      "dev:add_people",
      "dev:add_people_memories",
      "dev:add_images"] do
      puts "done"
    end

    task add_users: :environment do
      puts "adding users..."
      names = ["brian", "calvin", "thierry"]
      names.each do |name|
        u = User.create(
          email: "#{name}@example.com",
          password: "Password123!",
        )
      end 
      User.find_by(email: "thierry@example.com").update(admin: true)
    end

    task add_memories: :environment do 
      puts "adding memories..."
      50.times do
        Memory.create(
          author_id: User.all.sample.id,
          date: Faker::Date.backward(days: 40*365),
          title: Faker::Quote.most_interesting_man_in_the_world,
          description: Faker::TvShows::Spongebob.quote,
          place: Faker::Address.city,
          lat: Faker::Address.latitude,
          lng: Faker::Address.longitude,
          country: Faker::Address.country
        )
      end
    end

    task add_people: :environment do
      puts "adding people..."
      50.times do
        Person.create(
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          alternate_name: Faker::Name.middle_name,
          date_of_birth: Faker::Date.backward(days: 40*365),
          user_id: User.all.sample.id
        )
      end 
    end

    task add_people_memories: :environment do
      puts "adding people_memories..."
      Memory.all.each do |memory|
        rand(1..3).times do
          pm = PeopleMemory.create(
            memory_id: memory.id,
            person_id: memory.author.people.sample.id,
          )
        end
      end 
    end

    task add_images: :environment do 
      puts "adding images..."
      Memory.all.each do |memory|
        new = Medium.create(
          url: "https://robohash.org/#{rand(9999)}",
          mediumable_type: 'Memory',
          mediumable_id: memory.id,
        )
      end
      Person.all.each do |person|
        new = Medium.create(
          url: "https://robohash.org/#{rand(9999)}",
          mediumable_type: 'Person',
          mediumable_id: person.id,
        )
      end
    end
  end
end
