# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "a@a",
  password: "aaaaaa"
)

Customer.create!(
  [
    {
      first_name: "山下",
      last_name: "美月",
      first_name_kana: "ヤマシタ",
      last_name_kana: "ミヅキ",
      email: "0@0",
      postal_code: "5420076",
      address: "大阪府大阪市中央区難波4-4-4 難波御堂筋センタービル 8階",
      telephone_number: "00088889999",
      is_active: true,
      password: "000000",
    },
    {
      first_name: "胡桃",
      last_name: "桃",
      first_name_kana: "クルミ",
      last_name_kana: "モモ",
      email: "1@1",
      postal_code: "1066223",
      address: "東京都港区六本木3-2-1 住友不動産六本木グランドタワー 23F",
      telephone_number: "09177772222",
      is_active: false,
      password: "111111",
    }
  ]
)
Address.create!(
  [
    {
      customer_id: 1,
      name: "渋谷",
      postal_code: "1500041",
      destination: "東京都渋谷区神南1-2-3 スクエア 30階"
    },
    {
      customer_id: 1,
      name: "新宿",
      postal_code: "1600022",
      destination: "東京都新宿区新宿9-9-9 ビル 9階"
    },
    {
      customer_id: 1,
      name: "大阪",
      postal_code: "5420076",
      destination: "大阪府大阪市中央区難波4-4-14 ビル 4階"
    }
  ]
)
Genre.create!(
  [
    {
      name: "ケーキ",
      is_active: true,
    },
    {
      name: "焼き菓子",
      is_active: true,
    },
    {
      name: "プリン",
      is_active: false,
    },
    {
      name: "和菓子",
      is_active: false,
    },
    {
      name: "アイス",
      is_active: true,
    }
  ]
)
  
images = ["cake", "cookies", "pudding"]
names  = ["ケーキ", "クッキー", "プリン"] 

for i in 1..10 do
  for j in 1..3 do
    name = names[j-1]
    image = images[j-1]
    item = Item.new(
      genre_id: j,
      name: "#{name}#{i}",
      introduction: "#{3*i-2-j}番目の商品です。",
      price: rand(1..10) * (j * 100),
      is_active: true
    )
    
    file_path = Rails.root.join("./app/assets/images/#{image}#{i%5+1}.jpg")
    item.image.attach(io: File.open(file_path), filename: image)
    
    item.save
  end
end