# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ZFormat.create!(identifier: :unknown, description: 'Unknown format', mime_type: 'application/octet-stream', accepted_extensions: [], default: true)
ZFormat.create!(identifier: :pdf, description: 'PDF', mime_type: 'application/pdf', accepted_extensions: ['pdf'], default: false)
ZFormat.create!(identifier: :p7m, description: 'PKCS#7', mime_type: 'application/pkcs7-data', accepted_extensions: ['pdf'], default: false)

# f = Rails.root.join('db', 'seeds', "#{Rails.env}.rb").to_s
# require f
