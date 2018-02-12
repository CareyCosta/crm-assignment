require_relative "contact"
require "pry"

class CRM

  def initialize(name)
    @name = name
  end

  def main_menu
    while true # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts "====== Main Menu ============="
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Search by attribute"
    puts "[6] Exit"
    print "Enter a number: "
  end

  def call_option(user_selected)
    puts "\e[H\e[2J"
    case user_selected
      when 1 then add_new_contact
      when 2 then modify_existing_contact
      when 3 then delete_contact
      when 4 then display_all_contacts
      when 5 then search_by_attribute
      when 6 then exit
      else puts "Invalid option!"
    end
  end

  def add_new_contact
    puts "------ Option 1: Add a new contact ------"
    print "Enter First Name: "
    first_name = gets.chomp

    print "Enter Last Name: "
    last_name = gets.chomp

    print "Enter Email Address: "
    email = gets.chomp

    print "Enter a Note: "
    note = gets.chomp

    Contact.create( first_name: first_name, last_name: last_name, email: email, note: note)
    puts "Contact added."
    pause_screen
  end

  def modify_existing_contact
    puts "------ Option 2: Modify an existing contact ------"
    print "Enter an ID: "
    id = gets.chomp.to_i

    a_contact = Contact.find(id)

    if a_contact == nil
      puts "ID: #{id} not found!"
    else
      puts "Record to modify:-"
      puts "Name: #{a_contact.full_name}, Email: #{a_contact.email}, Note: #{a_contact.note}, ID: #{a_contact.id}"

      print_modify_attribute_menu
      user_selected = gets.to_i
      display_input_msg(user_selected)
      user_input = gets.chomp
      modify_to = get_attribute_name(user_selected)
      a_contact.update({modify_to => user_input})
      puts "Contact modified."
    end
    pause_screen
  end

  def print_modify_attribute_menu
    puts ""
    puts "------ Select the field to modify ------"
    puts "[1] Modify First Name"
    puts "[2] Modify Last Name"
    puts "[3] Modify Email"
    puts "[4] Modify Note"
    print "Enter a number: "
  end

  def delete_contact
    puts "------ Option 3: Delete a contact ------"
    print "Enter an ID: "
    id = gets.chomp.to_i

    a_contact = Contact.find(id)

    if a_contact == nil
      puts "ID: #{id} not found!"
    else
      puts "Record to delete:-"
      puts "Name: #{a_contact.full_name}, Email: #{a_contact.email}, Note: #{a_contact.note}, ID: #{a_contact.id}"

      print "Enter \"Y\" to confirm the delete: "
      confirm_flag = gets.chomp

      if confirm_flag == "Y"
        a_contact.delete
        puts "Contact deleted."
      end
    end
    pause_screen
  end

  def display_all_contacts
    puts "------ Option 4: Display all the contacts ------"
    all_contacts = Contact.all
    all_contacts.each do |a_contact|
      puts "Name: #{a_contact.full_name}, Email: #{a_contact.email}, Note: #{a_contact.note}, ID: #{a_contact.id}"
    end
    pause_screen
  end

  def search_by_attribute
    print_search_by_attribute_menu
    user_selected = gets.to_i
    display_input_msg(user_selected)
    user_input = gets.chomp
    call_option_5(user_selected, user_input)
  end

  def print_search_by_attribute_menu
    puts "------ Option 5: Search by attribute ------"
    puts "[1] Search by First Name"
    puts "[2] Search by Last Name"
    puts "[3] Search by Email"
    puts " "
    puts "[5] Search by ID"
    print "Enter a number: "
  end

  def call_option_5(user_selected, user_input)
    if user_selected == 1
      search_by = "first_name"
    elsif user_selected == 2
      search_by = "last_name"
    elsif user_selected == 3
      search_by = "email"
    elsif user_selected == 5
      search_by = "id"
      user_input = user_input.to_i
    else
      puts "Invalid option!"
      pause_screen
      return
    end

    search_by = get_attribute_name(user_selected)
    a_contact = Contact.find_by({search_by => user_input})
    if a_contact == nil
      puts "#{search_by}: #{user_input} not found!"
    else
      puts "Record found:-"
      puts "Name: #{a_contact.full_name}, Email: #{a_contact.email}, Note: #{a_contact.note}, ID: #{a_contact.id}"
    end
    pause_screen
  end

  def display_input_msg(attribute_option)
    case attribute_option
      when 1 then option_text = "First Name"
      when 2 then option_text = "Last Name"
      when 3 then option_text = "Email Address"
      when 4 then option_text = "a Note"
      when 5 then option_text = "an ID"
    end
    print "Enter #{option_text}: "
  end

  def get_attribute_name(attribute_option)
    case attribute_option
      when 1 then return "first_name"
      when 2 then return "last_name"
      when 3 then return "email"
      when 4 then return "note"
      when 5 then return "id"
    end
  end

  def pause_screen
    print "--Press Enter to continue--"
    gets.chomp
    puts "\e[H\e[2J"
  end

end

puts "\e[H\e[2J"
a_crm_app = CRM.new("My CRM App")
a_crm_app.main_menu
