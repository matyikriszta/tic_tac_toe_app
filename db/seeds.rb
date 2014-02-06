# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Player.delete_all

u = Player.new(name: "Kriszta", email: "kriszta@kriszta.com", password: "kriszta", password_confirmation: "kriszta")
u.role = :admin
u.save!

Player.create name: "Tim", email: "tim@tim.com", password: "tim", password_confirmation: "tim", role: "registered"
Player.create name: "Alex", email: "alex@alex.com", password: "alex", password_confirmation: "alex", role: "registered"
Player.create name: "Michael", email: "michael@michael.com", password: "michael", password_confirmation: "michael", role: "registered"
