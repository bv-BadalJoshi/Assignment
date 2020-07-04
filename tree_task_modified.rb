#Tree Structure
class Tree
  attr_accessor :val, :left, :right

  def initialize(val)
    @val=val
    @left=nil
    @right=nil
  end
end

#This class handles some intermediate operation needed by other classes
class Utilities
  def self.serialize(root, name)
    tree_string=""
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

  def self.deserialize(name)
    begin                                             #Exception Handled
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
      q.push(temp_node) if arr[i]!="nil"
      
      if left_exists == 1
        ptr = q.shift
        ptr.left = temp_node
        left_exists=0
      else
        ptr.right = temp_node
        left_exists = 1
      end
    end
    return root 
  end

  def self.rearrange_tree(root)
    return nil if !root.left && !root.right
    return root.left if !root.right
    return root.right if !root.left
    left_node = root.left
    while left_node.right
      left_node = left_node.right
    end
    left_node.right=root.right
    return root.left
  end

  def self.find_all_paths(root, paths, temporary_path="")
    return nil if root==nil
    paths.push(temporary_path + root.val.to_s) if !root.left && !root.right
    temporary_path = temporary_path + root.val.to_s + " ";
    find_all_paths(root.left, paths, temporary_path)
    find_all_paths(root.right, paths, temporary_path) 
  end
end

#Performs Traversals
class Traversal
  def self.preorder(root)
    return nil if root.nil?
    puts root.val
    preorder(root.left)
    preorder(root.right)
  end

  def self.postorder(root)
    return nil if root.nil?
    postorder(root.left)
    postorder(root.right)
    puts root.val
  end
  
  def self.inorder(root)
    return nil if root.nil?
    inorder(root.left)
    puts root.val 
    inorder(root.right)
  end

  def self.levelorder(root)
    return nil if root.nil?
    queue = [root]
    while !queue.empty?
      queueSize = queue.size
      for i in 0...queueSize
        node = queue.shift
        queue.push(node.left) unless node.left == nil
        queue.push(node.right) unless node.right == nil
	puts node.val
      end
    end
  end
  
  def self.find(root)                            #Find all root to leaf path
    paths=[]
    Utilities.find_all_paths(root, paths)
    paths.each{ |s| puts s }
  end    
end


# Find Minimum and Maximum Element
class MinMax
  def self.largest(root)
    if !root
      puts "Empty Tree"
      return nil
    end

    while root.right
      root = root.right
    end
    puts root.val
  end

  def self.smallest(root)
    if !root
      puts "Empty Tree"
      return nil
    end
    while root.left
      root = root.left    
    puts root.val
    end
  end
end

#For handling add, remove and search case
class Crud
  def self.add_element(value,root)
    return Tree.new(value) if root.nil?
    root_node = root
    previous_node = nil
    while root
      return nil if root.val==value
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

  def self.search_element(value,root)
    while root
      return 1 if root.val==value
      if value > root.val
        root = root.right
      else
        root = root.left
      end
    end
    return 0
  end

  def self.remove_element(value, root)
    return nil if root==nil
    if root.val == value
      return Utilities.rearrange_tree(root)
    end
    root.left = remove_element(value, root.left)
    root.right = remove_element(value, root.right)
    return root  
  end

end

# Read and Write in File
class InputOutput
  def self.read_from_file(root, name)
    return Utilities.deserialize(name)
  end

  def self.write_in_file(root, name)
    Utilities.serialize(root,name)
  end

end
 
# for taking user input for different cases
class Driver
  def start
    choices = 
      [ "Preorder", "Postorder", "Inorder", "levelorder",
        "Largest", "Smallest", "AddElement", "Search",
        "Remove", "Path", "OpenFile"]  
    root=nil
    script_loop="looping" 
    while script_loop!="quit"
      choices.each_with_index{|s, idx| puts " #{idx + 1}. #{s}"}
      options=gets.chomp.to_i
      case options
      when 1
        Traversal.preorder(root)
      when 2
        Traversal.postorder(root)
      when 3
        Traversal.inorder(root)
      when 4
        Traversal.levelorder(root)
      when 5
        MinMax.largest(root)
      when 6
        MinMax.smallest(root)
      when 7
        val = gets.chomp.to_i
        root =  Crud.add_element(val,root)
      when 8
        val = gets.chomp.to_i
        puts Crud.search_element(val,root)
      when 9
        val = gets.chomp.to_i
        root = Crud.remove_element(val,root)
      when 10
        Traversal.find(root)
      when 11
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

run_code=Driver.new
run_code.start()
