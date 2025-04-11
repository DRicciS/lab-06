# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Message.delete_all
Chat.delete_all
User.delete_all

emails = ['juanma@mail.com',  'richard@hello.cl',
    'dog@whyImdoingthis.io',
    'class22@Ihavetostudyfinance.it',
    'saem@a.com',
    'alice@ia.org',
    'bob@nik.cl',
    'carla@gob.com',
    'julianpin@colombia.co',
    'aaasadasd@enel.it']

first_names = [
    'Juan',
    'Ricardo',
    'Dog',
    'Migel',
    'Saem',
    'Alicia',
    'Bob',
    'Carla',
    'Julian',
    'Arroz']

last_names = [
    'Pere',
    'Rodri',
    'Alonso',
    'Luca',
    'SAd',
    'Smith',
    'Loresdsadsada',
    'Ramos',
    'Pineda',
    'Enel']

emails.each_with_index do |email, i|
    User.create!(
      email:      email,
      first_name: first_names[i],
      last_name:  last_names[i]
    )
  end
users = User.all  
#Hay una forma ma rapida en vdd

10.times do
    sender   = users.sample
    receiver = (users - [sender]).sample
  
    Chat.create!(
      sender_id:   sender.id,
      receiver_id: receiver.id
    )
  end
  
chats = Chat.all

10.times do |i|
    chat   = chats.sample
    author = [chat.sender_id, chat.receiver_id].map { |uid| User.find(uid) }.sample
  
    Message.create!(
      chat_id: chat.id,
      user_id: author.id,
      body:    "Mensage nro ##{i + 1}"
    )
  end