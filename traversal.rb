require_relative "tree"
require_relative "utilities"

#Performs Traversals
module Traversal
  def Traversal.preorder(root)
    return nil if root.nil?
    puts root.val
    preorder(root.left)
    preorder(root.right)
  end

  def Traversal.postorder(root)
    return nil if root.nil?
    postorder(root.left)
    postorder(root.right)
    puts root.val
  end
  
  def Traversal.inorder(root)
    return nil if root.nil?
    inorder(root.left)
    puts root.val 
    inorder(root.right)
  end

  def Traversal.levelorder(root)
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
  
  def Traversal.find(root)                            #Find all root to leaf path
    paths=[]
    Utilities.find_all_paths(root, paths)
    paths.each{ |s| puts s }
  end    
end


