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
		root = nil
		script_loop = "looping" 
		until script_loop == "quit"
			Operation::DISPLAY_OPERATIONS.sort.each{ |key, val| puts "#{key} #{val}"}
			operation = gets.chomp.to_i
			case operation
			when Operation::PREORDER
				Traversal.preorder(root)
			when Operation::POSTORDER
				Traversal.postorder(root)
			when Operation::INORDER
				Traversal.inorder(root)
			when Operation::LEVELORDER
				Traversal.levelorder(root)
			when Operation::LARGEST
				MinMax.largest(root)
			when Operation::SMALLEST
				MinMax.smallest(root)
			when Operation::ADD_ELEMENT
				val = gets.chomp.to_i
				root =  Crud.add_element(val,root)
			when Operation::SEARCH_ELEMENT
				val = gets.chomp.to_i
				puts Crud.search_element(val,root)
			when Operation::REMOVE_ELEMENT
				val = gets.chomp.to_i
				root = Crud.remove_element(val,root)
			when Operation::PATH
				Traversal.find(root)
			when Operation::OPEN_FILE
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
