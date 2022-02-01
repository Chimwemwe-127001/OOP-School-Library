require_relative 'person'
require_relative 'student'
require_relative 'rental'
require_relative 'book'
require_relative 'teacher'
require_relative 'classroom'

class App
  def initialize
    @books = []
    @rentals = []
    @people = []
  end

  def get_num(option)
    case option
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_rentals_by_person_id
    else
      puts 'Please enter a number between 1 and 7'
    end
  end

  def list_all_books
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    sleep 0.75
  end

  def list_all_people
    @people.map { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    sleep 0.75
  end

  def create_person
    print 'Do you want to create a student(1) or a teacher(2)? [Input the number]:'
    input = gets.chomp.to_i
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp
    case input
    when 1
      create_student(age, name)
    when 2
      create_teacher(age, name)
    end
    puts 'Person created successfully!'
  end

  def create_student
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase

    parent_permission = gets.chomp.upcase == 'Y'
    @people << Student.new(name, age, parent_permission)

    puts 'Student created successfully'
    sleep 0.75
  end

  def create_teacher
    print 'Specialization: '
    specialization = gets.chomp

    @people << Teacher.new(specialization, age, name)

    puts 'Teacher created successfully'
    sleep 0.75
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)

    puts 'Book added successfully'
    sleep 0.75
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) #{book}" }

    book_id = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index { |person, index| puts "#{index}) #{person}" }

    person_id = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp.to_s

    @rentals << Rental.new(date, @people[person_id], @books[book_id])

    puts 'Rental created successfully'
    sleep 0.75
  end

  def list_rentals_by_person_id
    print 'ID of person: '
    id = gets.chomp.to_i

    puts 'Rentals:'
    @rentals.each { |rental| puts rental if rental.person.id == id }
    sleep 0.75
  end
end
