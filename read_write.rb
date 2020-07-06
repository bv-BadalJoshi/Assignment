require_relative "tree"
require_relative "utilities"
# Read and Write in File
module InputOutput
  def InputOutput.read_from_file(root, name)
    return Utilities.deserialize(name)
  end

  def InputOutput.write_in_file(root, name)
    Utilities.serialize(root,name)
  end

end
 
