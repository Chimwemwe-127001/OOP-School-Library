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
      JSON.parse(File.read(file)).each do |person|
        if person[key] == 'Teacher'
          data.push(Teacher.new(id: person['id'], age: person['age'],
                                specialization: person['specialization'], name: person['name']))
        else
          data.push(Student.new(id: person['id'], age: person['age'], name: person['name'],
                                parent_permission: person['parent_permission']))
        end
      end
    end
    data
  end

  def load_books
    data = []
    file = 'book.json'
    if File.exist?(file)
      JSON.parse(File.read(file)).map do |book|
        data.push(Book.new(title: book['title'], author: book['author']))
      end
    end
    data
  end
  def save_person
     data = []
     @people.each do |person|
       if person.instance_of?(Teacher)
         data.push({ id: person['id'], age: person['age'],
                                specialization: person['specialization'], name: person['name'], key: person.class })
        else 
         data.push({ id: person['id'], age: person['age'], name: person['name'],
                                parent_permission: person['parent_permission'], key: person.class })
       end
       File.write('person.json', JSON.generate(data))
  end

  def save_books
    data = []
    @books.each do |book|
      data.push({ title: book['title'], author: book['author'] })
    end
    File.write('books.json', JSON.generate(data))
  end

    def save_rentals
    data = []
    @rentals.each do |rental|
      data.push({ date: rental['date'], book_title: rental.book.title, person_id: rental.person.id })
    end
    File.write('rentals.json', JSON.generate(data))
  end
end
