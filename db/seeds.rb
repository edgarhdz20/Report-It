# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
role = Role.create(name:'Admin',description:'Administrador')
User.create(first_name:'edgar',last_name:'hernandez',role_id: role.id,email:'edgarhg20@gmail.com',password:'123456',username:'admin')
