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
      "dev:add_addresses",
      "dev:add_memories",
      "dev:add_people",
      "dev:add_people_memories"] do
      puts "done"
    end

    task add_users: :environment do
      puts "adding users..."
      names = ["brian", "calvin", "thierry"]
      names.each do |name|
        u = User.create(
          email: "#{name}@example.com",
          password: "Password123!"
        )
        puts u.email
      end 
    end

    task add_addresses: :environment do 
      puts "adding addresses..."
      25.times do
        Address.create(
          location: Faker::Address.city,
        )
      end
    end

    task add_memories: :environment do 
      puts "adding memories..."
      25.times do
        Memory.create(
          author_id: User.all.sample.id,
          date: Faker::Date.backward(days: 40*365),
          description: Faker::TvShows::Spongebob.quote,
          address_id: Address.all.sample.id,
        )
      end
    end

    task add_people: :environment do
      puts "adding people..."
      25.times do
        Person.create(
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          user_id: User.all.sample.id
        )
      end 
    end

    task add_people_memories: :environment do
      puts "adding people_memories..."
      Memory.all.each do |memory|
        pm = PeopleMemory.create(
          memory_id: memory.id,
          person_id: memory.author.people.sample.id,
        )
      end 
    end

  end
end
