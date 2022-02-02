require_relative 'person'
require_relative 'student'
require_relative 'rental'
require_relative 'book'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'data_store'

class App
  include StoreData
  def initialize
    @books = load_books
    @rentals = load_rentals
    @people = load_person
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
    puts 'There are no books yet! Kindly add books.' if @books.empty?

    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    sleep 0.75
  end

  def list_all_people
    puts 'There are no people yet! Kindly add a student or teacher.' if @people.empty?
    @people.map { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    sleep 0.75
  end

  def person_details
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp
    [age, name]
  end

  def create_person
    print 'Do you want to create a student (1) or teacher (2) [Input a number]: '
    option = gets.chomp
    age, name = person_details
    case option
    when '1'
      create_student(age, name)
    when '2'
      create_teacher(age, name)
    end
    puts 'Person created successfully!'
  end

  def create_student(age, name)
    print 'Has parent permission? [Y/N]: '

    parent_permission = gets.chomp.upcase == 'Y'
    @people << Student.new(name, age, parent_permission)

    puts 'Student created successfully'
    sleep 0.75
  end

  def create_teacher(age, name)
    print 'Specialization: '
    specialization = gets.chomp

    @people << Teacher.new(specialization, age, name)

    puts 'Teacher created successfully'
    sleep 0.75
  end

  def book_details
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp
    [title, author]
  end

  def create_book
    title, author = book_details
    @books << Book.new(title, author)

    puts 'Book added successfully'
    sleep 0.75
  end

  def rental_details
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }

    book_id = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    person_id = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp.to_s
    [book_id, person_id, date]
  end

  def create_rental
    book_id, person_id, date = rental_details
    @rentals << Rental.new(date, @people[person_id], @books[book_id])

    puts 'Rental created successfully'
    sleep 0.75
  end

  def list_rentals_by_person_id
    print 'ID of person: '
    id = gets.chomp.to_i

    puts 'Rentals:'
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}" if rental.person.id == id
    end
    sleep 0.75
  end
end
