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
    while @logged_in
      user_menu
    end
    select_user
  end

  def welcome_message
    system("clear")
    puts "Welcome to --Get It Done--"
  end

  def select_user
    puts "(1) New User\n(2) Login\n(3) Exit"
    get_input
    case @input
    when "1"
      print "Enter your name: "
      @user = User.find_or_create_by(name: get_input)
      @logged_in = true
    when "2"
      display_user_list
      @user = User.find(get_input)
      @logged_in = true
    when "3"
      puts "Goodbye!"
      sleep 1
      system("clear ")
      exit
    else
      puts "That's not a valid option."
      select_user
    end
  end

  def display_user_list
    puts "---Users---"
    @user_list.each { |user| puts "#{user.id} | #{user.name}" }
  end

  def user_menu
    puts "(1) View Todo Lists\n(2) Create New Todo List\n(3) Log Out"
    get_input
    case @input
    when "1"
      load_user_todo_lists
    when "2"
      create_new_todo_list
    when "3"
      puts "Goodbye #{@user.name}!"
      @logged_in = false
    else
      puts "That's not a valid option."
      user_menu
    end
  end

  def load_user_todo_lists
    @todo_list = Todo_List.where(user_id: @user.id)
    puts "------To Do Lists------"
    @todo_list.each do |item|
      puts "(#{item.id}) #{item.list_name}"
    end
  end

  def create_new_todo_list
    print "Name your list: "
    Todo_List.create(list_name: get_input, user_id: @user.id, todo_id: @user.id)
  end

  def get_input
    @input = gets.chomp
  end

end

Get_It_Done.new.start
