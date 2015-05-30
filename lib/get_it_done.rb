require_relative "../db/setup.rb"
require_relative "todo"
require_relative "todo_list"
require_relative "user"

class Get_It_Done
  def start
    welcome_message
    select_user
  end

  def welcome_message
    system("clear")
    puts "Welcome to --Get It Done--"
  end

  def select_user
    puts "(1) New User\n(2) Login"
    get_input
    case @input
    when "1"
      puts "Enter your name"
      User.create(get_input)
    when "2"
    else
      puts "That's not a valid option."
      select_user
    end
  end

  def get_input
    @input = gets.chomp
  end
end

Get_It_Done.new.start
