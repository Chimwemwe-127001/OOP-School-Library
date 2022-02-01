class Rental
  attr_accessor :date, :person, :book

  def initialize(date, person, book)
    @date = date

    @person = person
    person.rentals << self

    @book = book
    book.rentals << self
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'date' => @date,
      'book' => @book,
      'person' => @person
    }.to_json(*args)
  end
end
