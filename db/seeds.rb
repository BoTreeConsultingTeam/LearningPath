# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = ['Blog Post','Video','Podcast','Tutorial']

categories.each do |name|
  Category.create(name: name) unless Category.find_by_name(name).present?
end
puts 'Categories created!!'

learning_statuses = ['Not yet Learned', 'Learned', 'Want to Learn Again']

learning_statuses.each do |status|
  LearningStatus.create(status: status) unless LearningStatus.find_by_status(status)
end
puts 'Statuses created!!'