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
      }
    ]
  } # Topic biology
] # topics



# Add table for tag_weights

puts "Generating database"
topics.each do |topic|
  new_topic = Topic.create(name: topic[:name])
  topic[:pages].each do |page|
    new_page = Page.create(name: page[:name], free_content: page[:free_content], member_content: page[:member_content], topic_id: new_topic.id)

    page[:tags].each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      new_page.tags << tag
    end
  end
end

# Generate table for tag_weights

puts "End of seed script!"
