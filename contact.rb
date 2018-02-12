gem 'activerecord', '=4.2.10'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')

class Contact

  @@contacts = []
  @@id = 1

  # This method should initialize the contact's attributes
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
    @id = @@id
    @@id += 1
  end

  # READERS
  def first_name
    @first_name
  end

  def last_name
    @last_name
  end

  def email
    @email
  end

  def note
    @note
  end

  def id
    @id
  end

  # WRITTERS
  def first_name=(first_name)
    @first_name = first_name
  end

  def last_name=(last_name)
    @last_name = last_name
  end

  def email=(email)
    @email = email
  end

  def note=(note)
    @note = note
  end

  # This method should call the initializer,
  # store the newly created contact, and then return it
  def self.create(first_name, last_name, email, note)
    new_contact = Contact.new(first_name, last_name, email, note)
    @@contacts << new_contact
    return new_contact
  end

  # This method should return all of the existing contacts
  def self.all
    @@contacts
  end

  # This method should accept an id as an argument
  # and return the contact who has that id
  def self.find(id)
    @@contacts.each do |a_contact|
      if a_contact.id == id
        return a_contact
      end
    end
    return nil
  end

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  def update(attribute_name, attribute_value)
    if attribute_name == "first_name"
      self.first_name = attribute_value
    elsif attribute_name == "last_name"
      self.last_name = attribute_value
    elsif attribute_name == "email"
      @email = attribute_value
      self.email = attribute_value
    elsif attribute_name == "note"
      @note = attribute_value
      self.note = attribute_value
    end
  end

  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty
  def self.find_by(attribute_name, attribute_value)
    @@contacts.each do |a_contact|
      if ((attribute_name == "first_name") && (a_contact.first_name == attribute_value)) ||
         ((attribute_name == "last_name") && (a_contact.last_name == attribute_value)) ||
         ((attribute_name == "email") && (a_contact.email == attribute_value)) ||
         ((attribute_name == "id") && (a_contact.id == attribute_value))
        return a_contact
      end
    end
    return nil
  end

  # This method should delete all of the contacts
  def self.delete_all
    @@contacts = []
  end

  def full_name
    "#{ last_name }, #{ first_name }"
  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  def delete
    @@contacts.delete_if {|a_contact| a_contact.id == @id }
  end

  # Feel free to add other methods here, if you need them.

end
