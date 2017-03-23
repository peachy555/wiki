# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Start of seed script!"

puts "Generating data"
topics = [
  {
    name: "Biography",
    pages: [
      {
        name: "Jason Statham",
        free_content: "Jason's free content",
        member_content: "Jason's member content",
        tags: ["Action (Movie)", "Movie star"]
      },
      {
        name: "Hugh Jackman",
        free_content: "Hugh's free content",
        member_content: "Hugh's member content",
        tags: ["Action (Movie)", "Movie star", "Sci-fi", "X-Men"]
      },
      {
        name: "Vin Diesel",
        free_content: "Vin's free content",
        member_content: "Vin's member content",
        tags: ["Action (Movie)", "Movie star", "Thriller", "Fast and Furious"]
      }
    ] # Biography pages
  },
  {
    name: "Biology",
    pages: [
      {
        name: "Hedgehog",
        free_content: "Hedgehog's free content",
        member_content: "Hedgehog's member content",
        tags: ["Animal", "Mammal", "Nocturnal"]
      },
      {
        name: "Orangutan",
        free_content: "Orangutan's free content",
        member_content: "Orangutan's member content",
        tags: ["Animal", "Mammal", "Monkey"]
      },
      {
        name: "Chimpanzee",
        free_content: "Chimpanzee's free content",
        member_content: "Chimpanzee's member content",
        tags: ["Animal", "Mammal", "Monkey"]
      },
      {
        name: "Mouse",
        free_content: "Mouse's free content",
        member_content: "Mouse's member content",
        tags: ["Animal", "Mammal", "Pest"]
      },
      {
        name: "Cockroach",
        free_content: "Cockroach's free content",
        member_content: "Cockroach's member content",
        tags: ["Animal", "Insect", "Pest"]
      },
      {
        name: "Butterfly",
        free_content: "Butterfly's free content",
        member_content: "Butterfly's member content",
        tags: ["Animal", "Insect"]
      }
    ]
  } # Topic biology
] # topics

tag_weights = [
  {page_id: 1, tag_id:  1, score: 2}, # Jason => Action (Movie)
  {page_id: 1, tag_id:  2, score: 2}, # Jason => Movie Star
  {page_id: 2, tag_id:  1, score: 4}, # Hugh => Action (Movie)
  {page_id: 2, tag_id:  2, score: 2}, # Hugh => Movie Star
  {page_id: 2, tag_id:  3, score: 7}, # Hugh => Sci-fi
  {page_id: 2, tag_id:  4, score: 9}, # Hugh => X-Men
  {page_id: 3, tag_id:  1, score: 2}, # Vin => Action (Movie)
  {page_id: 3, tag_id:  2, score: 1}, # Vin => Movie Star
  {page_id: 3, tag_id:  5, score: 2}, # Vin => Thriller
  {page_id: 3, tag_id:  6, score: 3}, # Vin => Fast and Furious
  {page_id: 4, tag_id:  7, score: 2}, # Hedgehog => Animal
  {page_id: 4, tag_id:  8, score: 4}, # Hedgehog => Mammal
  {page_id: 4, tag_id:  9, score: 2}, # Hedgehog => Nocturnal
  {page_id: 5, tag_id:  7, score: 2}, # Orangutan => Animal
  {page_id: 5, tag_id:  8, score: 6}, # Orangutan => Mammal
  {page_id: 5, tag_id: 10, score: 2}, # Orangutan => Monkey
  {page_id: 6, tag_id:  7, score: 5}, # Chimpanzee => Animal
  {page_id: 6, tag_id:  8, score: 2}, # Chimpanzee => Mammal
  {page_id: 6, tag_id: 10, score: 7}, # Chimpanzee => Monkey
  {page_id: 7, tag_id:  7, score: 2}, # Mouse => Animal
  {page_id: 7, tag_id:  8, score: 9}, # Mouse => Mammal
  {page_id: 7, tag_id: 11, score: 2}, # Mouse => Pest
  {page_id: 8, tag_id:  7, score: 2}, # Cockroach => Animal
  {page_id: 8, tag_id: 11, score: 1}, # Cockroach => Pest
  {page_id: 8, tag_id: 12, score: 2}, # Cockroach => Insect
  {page_id: 9, tag_id:  7, score: 1}, # Butterfly => Animal
  {page_id: 9, tag_id: 12, score: 2}  # Butterfly => Insect
]

users = [
  {
    username: 'Free',
    email: 'free@wiki.com',
    password: 'test',
    user_type: 'free'
  },
  {
    username: 'Member',
    email: 'member@wiki.com',
    password: 'test',
    user_type: 'member'
  },
  {
    username: 'Admin',
    email: 'admin@wiki.com',
    password: 'test',
    user_type: 'admin'
  }
]

puts "Generating database"
topics.each do |topic|
  new_topic = Topic.create(name: topic[:name])
  topic[:pages].each do |page|
    new_page = Page.create(name: page[:name], free_content: page[:free_content], member_content: page[:member_content], topic_id: new_topic.id)

    page[:tags].each do |tag_name|
      new_tag = Tag.find_or_create_by(name: tag_name)
      new_page.tags << new_tag
    end
  end
end

tag_weights.each do |tag_weight|
  new_tag_weight = TagWeight.find_or_create_by(page_id: tag_weight[:page_id], tag_id: tag_weight[:tag_id], score: tag_weight[:score])
end

users.each do |user|
  new_user = User.new(username: user[:username], email: user[:email], password: user[:password], user_type: user[:user_type])
  new_user.save
end


puts "End of seed script!"
