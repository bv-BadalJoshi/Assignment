require_relative "tree"
# Find Minimum and Maximum Element
module MinMax
  def MinMax.largest(root)
    if !root
      puts "Empty Tree"
      return nil
    end
    while root.right
      root = root.right
    end
    puts root.val
  end

  def MinMax.smallest(root)
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


