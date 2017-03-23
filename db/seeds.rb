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
  {page_id: 1, tag_id:  1, user_id: 1},
  {page_id: 1, tag_id:  2, user_id: 1},
  {page_id: 1, tag_id:  2, user_id: 2},
  {page_id: 1, tag_id:  2, user_id: 3},
  {page_id: 2, tag_id:  1, user_id: 1},
  {page_id: 2, tag_id:  2, user_id: 1},
  {page_id: 2, tag_id:  2, user_id: 2},
  {page_id: 2, tag_id:  3, user_id: 1},
  {page_id: 2, tag_id:  4, user_id: 1},
  {page_id: 3, tag_id:  1, user_id: 1},
  {page_id: 3, tag_id:  1, user_id: 2},
  {page_id: 3, tag_id:  1, user_id: 3},
  {page_id: 3, tag_id:  2, user_id: 1},
  {page_id: 3, tag_id:  5, user_id: 1},
  {page_id: 3, tag_id:  5, user_id: 3},
  {page_id: 3, tag_id:  6, user_id: 1},
  {page_id: 4, tag_id:  7, user_id: 1},
  {page_id: 4, tag_id:  8, user_id: 1},
  {page_id: 4, tag_id:  8, user_id: 2},
  {page_id: 4, tag_id:  8, user_id: 3},
  {page_id: 4, tag_id:  9, user_id: 1},
  {page_id: 5, tag_id:  7, user_id: 1},
  {page_id: 5, tag_id:  7, user_id: 2},
  {page_id: 5, tag_id:  8, user_id: 1},
  {page_id: 5, tag_id:  8, user_id: 3},
  {page_id: 5, tag_id: 10, user_id: 1},
  {page_id: 6, tag_id:  7, user_id: 1},
  {page_id: 6, tag_id:  7, user_id: 2},
  {page_id: 6, tag_id:  7, user_id: 3},
  {page_id: 6, tag_id:  8, user_id: 1},
  {page_id: 6, tag_id: 10, user_id: 1},
  {page_id: 6, tag_id: 10, user_id: 3},
  {page_id: 7, tag_id:  7, user_id: 1},
  {page_id: 7, tag_id:  8, user_id: 1},
  {page_id: 7, tag_id:  8, user_id: 2},
  {page_id: 7, tag_id: 11, user_id: 1},
  {page_id: 8, tag_id:  7, user_id: 1},
  {page_id: 8, tag_id:  7, user_id: 3},
  {page_id: 8, tag_id: 11, user_id: 1},
  {page_id: 8, tag_id: 12, user_id: 1},
  {page_id: 8, tag_id: 12, user_id: 2},
  {page_id: 8, tag_id: 12, user_id: 3},
  {page_id: 9, tag_id:  7, user_id: 1},
  {page_id: 9, tag_id: 12, user_id: 1}
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
  new_tag_weight = TagWeight.find_or_create_by(page_id: tag_weight[:page_id], tag_id: tag_weight[:tag_id], user_id: tag_weight[:user_id])
end

users.each do |user|
  new_user = User.new(username: user[:username], email: user[:email], password: user[:password], user_type: user[:user_type])
  new_user.save
end


puts "End of seed script!"
