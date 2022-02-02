require_relative 'person'
require_relative 'student'
require_relative 'rental'
require_relative 'book'
require_relative 'teacher'
require 'json'

module StoreData
  def load_person
    data = []
    file = 'person.json'
    if File.exist?(file)
      JSON.parse(File.read(file)).each do |file|
        if file[key] == 'Teacher'
          data.push(Teacher.new(id: file['id'], age: file['age'],
                                specialization: file['specialization'], name: file['name']))
        else
          data.push(Student.new(id: file['id'], age: file['age'], name: file['name'],
                                parent_permission: file['parent_permission']))
        end
      end
    end
    data
  end
end
