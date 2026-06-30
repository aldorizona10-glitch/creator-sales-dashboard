# Seed data for Creator Sales Dashboard — demo sales for the showcase app
puts "Seeding Creator Sales Dashboard demo data..."

creator = Creator.find_or_create_by!(email: "demo@creator.dev") do |c|
  c.name = "Demo Creator"
  c.password = "showcase-demo-2026"
end

products_list = [
  { name: "The Independent Creator Playbook", price_cents: 2900 },
  { name: "Membership — Inner Circle", price_cents: 1900 },
  { name: "1:1 Strategy Call (60 min)", price_cents: 14900 },
  { name: "Stock Photo Pack #3 — Studio", price_cents: 4900 },
  { name: "Notion OS for Creators", price_cents: 3900 },
  { name: "Email Course — 7 day launch", price_cents: 9900 }
]

created_products = products_list.map do |attrs|
  Product.find_or_create_by!(creator: creator, name: attrs[:name]) do |p|
    p.description = "Demo product for #{attrs[:name]}"
    p.price_cents = attrs[:price_cents]
    p.currency = "USD"
  end
end

# Clear old demo data
Sale.where(creator: creator).destroy_all

random = Random.new(42)
now = Time.current
domains = %w[gmail.com outlook.com proton.me hey.com fastmail.com]

180.times do |i|
  product = created_products.sample(random: random)
  days_ago = random.rand(0..75)
  created_at = now - days_ago.days - random.rand(0..23).hours - random.rand(0..59).minutes

  Sale.create!(
    creator_id: creator.id,
    product_id: product.id,
    buyer_email: "buyer#{random.rand(1000..9999)}@#{domains.sample(random: random)}",
    amount_cents: product.price_cents,
    currency: product.currency,
    created_at: created_at,
    updated_at: created_at,
  )
end

puts "Done: #{creator.email} — #{Product.count} products, #{Sale.where(creator: creator).count} sales"
