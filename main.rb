require './book'
require './classroom'
require './person'
require './rental'
require './student'
require './teacher'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def run
    puts 'Welcome to School Library!'
    loop do
      menu
      option = gets.chomp
      break if option == '7'

      get_num option
    end
    puts 'Thank you for using our Library!'
  end

  def menu
    puts 'Please choose an option by enterin a number:'
    puts '1 - List of all books'
    puts '2 - List of all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
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
      list_rentals_person_id
    else
      puts 'Enter a number between 1 & 7'
    end
  end

  def list_all_books
    @books.each { |book| puts book }
  end

  def list_all_people
    @people.each { |person| puts person }
  end

  def create_person
    print 'Do you want to create a student (1) or teacher (2) :'
    num = gets.chomp
    case num
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Please press number 1 or 2'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp

    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase

    student = Student.new(age, name, parent_permission, classroom: @classroom)
    @people.push(student)

    puts 'Student created successfully'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i

    print 'Name: '
    name = gets.chomp

    print 'Specialization'
    specialization = gets.chomp

    teacher = Teacher.new(age, name, specialization)
    @people.push(teacher)
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author:'
    author = gets.chomp

    book = Book.new(title, author)
    @books.push(book)

    puts 'Books created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book_id = gets.chomp.to_i

    puts 'Select a person from the following list by number (not ID)'
    @people.each_with_index { |person, index| puts "#{index}) #{person} " }
    person_id = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp
    rental = Rental.new(date, @books[book_id], @people[person_id])
    @rentals.push(rental)
    puts ' Rental created successfully'
  end

  def list_rentals_person_id
    print 'Person ID: '
    id = gets.chomp.to_i

    puts 'Rentals'
    @rentals.each { |rental| puts rental if rental.person.id == id }
  end
end

def main
  app = App.new
  app.run
end

main
