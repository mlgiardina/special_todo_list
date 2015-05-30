require_relative "../db/setup.rb"
require_relative "todo"
require_relative "todo_list"
require_relative "user"

class Get_It_Done

  def initialize
    @user_list = User.all
  end

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
      @user = User.find_or_create_by(name: get_input)
    when "2"
      display_user_list
      @user = User.find(get_input)
    else
      puts "That's not a valid option."
      select_user
    end
  end

  def display_user_list
    puts "---Users---"
    @user_list.each { |user| puts "#{user.id} | #{user.name}" }
  end

  def get_input
    @input = gets.chomp
  end
end

Get_It_Done.new.start
