require_relative "tree"
require_relative "utilities"
#For handling add, remove and search case
module Crud
	def Crud.add_element(value,root)
		return Tree.new(value) if root.nil?
		root_node = root
		previous_node = nil
		while root
			return nil if root.val == value
			previous_node = root
			if root.val > value
				root = root.left
			else
				root = root.right
			end
		end
		if value > previous_node.val
			previous_node.right = Tree.new(value)
		else
			previous_node.left = Tree.new(value)
		end
		return root_node 
	end

	def Crud.search_element(value,root)
		while root
			return 1 if root.val == value
			if value > root.val
				root = root.right
			else
				root = root.left
			end
		end
		return 0
	end

	def Crud.remove_element(value, root)
		return nil if root == nil
		if root.val == value
			return Utilities.rearrange_tree(root)
		end
		root.left = remove_element(value, root.left)
		root.right = remove_element(value, root.right)
		return root  
	end

end

