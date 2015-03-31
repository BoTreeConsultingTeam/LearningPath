# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = [['Ruby', 'ruby.png'],['Web', 'web.png'],['JS', 'js.png'],['CSS3', 'css3.png']]

categories.each do |name, icon|
  Category.create(name: name, icon: icon) unless Category.find_by_name(name).present?
end
puts 'Categories created!!'

learning_statuses = ['Not yet Learned', 'Learned', 'Want to Learn Again']

learning_statuses.each do |status|
  LearningStatus.create(status: status) unless LearningStatus.find_by_status(status)
end
puts 'Statuses created!!'

link_types = ['Blog Post', 'Video', 'Podcast', 'Tutorial']
link_types.each do |name|
  LinkType.create(name: name) unless LinkType.find_by_name(name)
end
puts 'Link Types Created!!'
