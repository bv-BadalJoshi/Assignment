require_relative "tree"
require_relative "crud"
require_relative "min_max_element"
require_relative "read_write"
require_relative "traversal"
require_relative "utilities"
require_relative "choices"
# for taking user input for different cases
class Driver
  def start 
    root=nil
    script_loop="looping" 
    while script_loop!="quit"
      options=gets.chomp.to_i
      case options
      when Choices::PREORDER
        Traversal.preorder(root)
      when Choices::POSTORDER
        Traversal.postorder(root)
      when Choices::INORDER
        Traversal.inorder(root)
      when Choices::LEVELORDER
        Traversal.levelorder(root)
      when Choices::LARGEST
        MinMax.largest(root)
      when Choices::SMALLEST
        MinMax.smallest(root)
      when Choices::ADD_ELEMENT
        val = gets.chomp.to_i
        root =  Crud.add_element(val,root)
      when Choices::SEARCH_ELEMENT
        val = gets.chomp.to_i
        puts Crud.search_element(val,root)
      when Choices::REMOVE_ELEMENT
        val = gets.chomp.to_i
        root = Crud.remove_element(val,root)
      when Choices::PATH
        Traversal.find(root)
      when Choices::OPEN_FILE
        name = gets.chomp
        root = InputOutput.read_from_file(root, name)
      else 
        puts "Not a correct input"
      end
      puts "successfull, press quit to exit"
      script_loop = gets.chomp.downcase
    end
    name = gets.chomp
    InputOutput.write_in_file(root, name)
  end
end

run_code = Driver.new
run_code.start()
