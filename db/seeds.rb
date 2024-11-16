# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

require 'faker'
require 'csv'
require 'net/http'
require 'json'

# Clear existing data
AdminUser.destroy_all
Author.destroy_all
Book.destroy_all
Genre.destroy_all
Review.destroy_all
Authorship.destroy_all
BookGenre.destroy_all

# Create admin user
AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if AdminUser.count == 0

# Create authors
10.times do
  Author.create!(
    name: Faker::Book.author,
    bio: Faker::Lorem.sentence
  )
end

# Create genres
5.times do
  Genre.create!(
    name: Faker::Book.genre
  )
end

# Create books
101.times do
  book = Book.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph,
    date: Faker::Date.backward(days: 365) # Ensure 'date' column exists in books table
  )

  # Create authorship
  Authorship.create!(
    author: Author.all.sample,
    book: book
  )

  # Create book genres
  BookGenre.create!(
    book: book,
    genre: Genre.all.sample
  )

  # Create reviews
  3.times do
    Review.create!(
      content: Faker::Lorem.sentence,
      rating: rand(1..5),
      book: book
    )
  end
end

# Create Books from an API
url = 'https://openlibrary.org/subjects/science_fiction.json?limit=20'
uri = URI(url)
response = Net::HTTP.get(uri)
books = JSON.parse(response)["works"]
books.each do |book|
  b = Book.create(
    title: book["title"],
    description: Faker::Lorem.paragraph,
    date: Faker::Date.between(from: '1900-01-01', to: '2023-01-01')
  )
  # Associate random authors
  b.authors << Author.order('RANDOM()').limit(2)
  # Associate random genres
  b.genres << Genre.order('RANDOM()').limit(2)
end

puts "Seeded #{Author.count} authors, #{Book.count} books, #{Genre.count} genres, #{Review.count} reviews, #{Authorship.count} authorships, #{BookGenre.count} book genres, #{AdminUser.count} admin users"