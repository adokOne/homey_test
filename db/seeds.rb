# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if User.count.zero?
  ROLES_TO_ADD = %w[admin moderator].freeze
  TEST_PASSWORD = 'password'.freeze

  admin = User.find_or_initialize_by(email: 'admin@example.com')
  admin.password = TEST_PASSWORD
  admin.password_confirmation = TEST_PASSWORD
  admin.save!

  ROLES_TO_ADD.each do |role_name|
    Role.find_or_initialize_by(name: role_name).save!
    admin.add_role(role_name)
  end
end
