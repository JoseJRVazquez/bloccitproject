require 'faker'
 
# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all
 
 
# Create Topics
15.times do
  Topic.create(
    name:         Faker::Lorem.sentence,
    description:  Faker::Lorem.paragraph 
  )         
end
topics = Topic.all
 
 
# Create Posts
50.times do
  Post.create(
    user:   users.sample,
    topic: topics.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )

  # set the created_at to a time within the past year
  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  post.update_ranks
end
posts = Post.all
 
# Create Comments
100.times do
  Comment.create(
    # user: users.sample,   # we have not yet associated Users with Comments
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end
 
# Create an admin user
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld'
)
admin.update_attribute(:role, 'admin')
admin.skip_confirmation!
if admin.save
  puts "Admin User Create"
else 
  admin.errors.full_messages.each do |message|
    puts message
  end
end
# Create an Moderator user
moderator = User.new(
  name:     'Moderator User',
  email:    'moderator@example.com',
  password: 'helloworld'
)
moderator.update_attribute(:role, 'moderator')
moderator.skip_confirmation!
if moderator.save
  puts "Moderator User Create"
else 
  moderator.errors.full_messages.each do |message|
    puts message
  end
end
 
# Create an Member user
member = User.new(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)
member.skip_confirmation!
member.save
 
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} Topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"