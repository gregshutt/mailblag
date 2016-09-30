# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
s = Site.create(hostname: 'localhost', require_password: true, title: 'Test site', is_default: true)

ActsAsTenant::current_tenant = s

SitePassword.create(password: 'test')

Post.create(title: "Test post please ignore", content: "Ignore this post\n\n**Please**",
  post_date: Date.today)