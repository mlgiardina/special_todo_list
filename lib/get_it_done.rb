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
    exit
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
      @user = User.find_or_create_by(name: get_input.to_s.downcase)
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
    select_user
  end

  def load_user_todo_lists
    @todo_list = Todo_List.where(user_id: @user.id)
    puts "------To Do Lists------"
    @todo_list.each do |item|
      puts "(#{item.id}) #{item.list_name}"
    end
    select_todo_list
    display_todo_list
    todo_list_menu
  end

  def display_todo_list
    reset_loaded_list if @loaded_list
    system("clear")
    puts "#{@current_list.list_name}"
    @loaded_list.each do |item| puts "#{item.id} | #{item.entry }" + " | " +
      if item.completed == false
        "incomplete"
      else
        "complete"
      end
    end
  end

  def select_todo_list
    puts "Which list would you like to view? Or type 0 to go back."
    get_input
    if @input == "0"
      user_menu
      @loaded_list = nil
      @current_list = nil
    else
      @current_list = Todo_List.find(@input)
    end
    reset_loaded_list
  end

  def reset_loaded_list
    @loaded_list = Todo.where(todo_list_id: @current_list.list_name)
  end

  def todo_list_menu
    puts "\n\nWhat would you like to do?\n"
    puts "(1) Add an entry"
    puts "(2) Mark an entry as complete"
    puts "(3) Delete an Entry"
    puts "(4) Update an Entry"
    puts "(5) Go back to your to to lists"
    puts "(6) Exit"
    get_input
    case @input
    when "1"
      add_todo
      display_todo_list
      todo_list_menu
    when "2"
      mark_todo_completed
      display_todo_list
      todo_list_menu
    when "3"
      delete_todo
      display_todo_list
      todo_list_menu
    when "4"
      update_todo
      display_todo_list
      todo_list_menu
    when "5"
      load_user_todo_lists
    when "6"
      puts "Goodbye, #{@user.name}!"
      sleep 1
      exit
    else
      puts "That's not a valid option."
      sleep 1
      todo_list_menu
    end
  end

  def add_todo
    puts "Add your entry:"
    get_input
    Todo.create(entry: @input, user_id: @user.id, todo_list_id: @current_list.list_name)
  end

  def mark_todo_completed
    puts "Which entry would you like to mark as completed?"
    Todo.update(get_input, completed: true)
  end

  def delete_todo
    puts "Which entry would you like to delete?"
    get_input
    Todo.delete(@input)
  end

  def update_todo
    display_todo_list
    puts "Which entry would you like to change?"
    entry_to_change = get_input
    puts "What would you like the entry to say?"
    get_input
    Todo.update(entry_to_change, entry: @input)
  end

  def create_new_todo_list
    print "Name your list: "
    Todo_List.create(list_name: get_input.to_s, user_id: @user.id, todo_id: @user.id)
    display_todo_list
    todo_list_menu
  end

  def get_input
    @input = gets.chomp
  end

end

Get_It_Done.new.start
