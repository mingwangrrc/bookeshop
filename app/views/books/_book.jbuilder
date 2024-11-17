json.extract! book, :id, :name, :description, :images, :price, :created_at, :updated_at
json.url book_url(book, format: :json)
json.description book.description.to_s
json.images do
  json.array!(book.images) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
