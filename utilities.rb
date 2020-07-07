require_relative "tree"
require_relative "crud"
require_relative "read_write"
require_relative "traversal"

#This module handles some intermediate operation needed by other classes
module Utilities
	def Utilities.serialize(root, name)                         #encoding tree to save in file
		tree_string = ""
		queue = [root]
		while !queue.empty?
			queueSize = queue.size
			for i in 0...queueSize
				node = queue.shift
				if node
					queue.push(node.left) 
					queue.push(node.right)
					tree_string = tree_string + node.val.to_s + " "
				else
					tree_string = tree_string + "nil " 
				end
			end
		end
		File.open(name + ".txt", 'w'){ |file| file.write(tree_string) }
	end

	def Utilities.deserialize(name)
		begin           
			file = File.open(name + ".txt")
		rescue SystemCallError => e
			puts "File Does not Exists"
			return nil
		end
		tree_string = file.read
		arr = tree_string.split(" ")
		left_exists = 1
		return nil if arr.size() == 0 || arr[0] == "nil"
		ptr=nil
		tree_node = Tree.new(arr[0].to_i)
		root = tree_node
		q = [root]
		for i in 1...arr.size()
			temp_node = arr[i] == "nil" ? nil : Tree.new(arr[i].to_i)
			q.push(temp_node) if arr[i] != "nil"
			if left_exists == 1
				ptr = q.shift
				ptr.left = temp_node
				left_exists = 0
			else
				ptr.right = temp_node
				left_exists = 1
			end
		end
		return root 
	end

	def Utilities.rearrange_tree(root)
		return nil if !root.left && !root.right
		return root.left if !root.right
		return root.right if !root.left
		left_node = root.left
		while left_node.right
			left_node = left_node.right
		end
		left_node.right = root.right
		return root.left
	end

	def Utilities.find_all_paths(root, paths, temporary_path = "")
		return nil if root == nil
		paths.push(temporary_path + root.val.to_s) if !root.left && !root.right
		temporary_path = temporary_path + root.val.to_s + " ";
		find_all_paths(root.left, paths, temporary_path)
		find_all_paths(root.right, paths, temporary_path) 
	end
end

