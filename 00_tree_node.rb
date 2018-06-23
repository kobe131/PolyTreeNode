require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent, :children
  
  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end
  
  def parent
    @parent
  end
  
  def children
    @children
  end
  
  def value
    @value
  end
  
  def inspect
    "<PolyTreeNode: #{"test"}"
  end
  
  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    @parent.children.push(self) unless @parent.nil? || @parent.children.include?(self)
  end
  
  def add_child(child_node)
      child_node.parent = self 
    
  end 
  
  def remove_child(child_node)
    raise 'node is not a child of this node' unless @children.include?(child_node)
    child_node.parent = nil 
  end 
  
  def dfs(target_value)
    # debugger
    return self if @value == target_value 
    # return nil if @children.empty?
    @children.each do |child|
      memo = child.dfs(target_value)
      if memo.is_a?(PolyTreeNode) && memo.value == target_value 
        return memo
      end 
    end 
    nil
  end 
  
  def bfs(target_value)
    que = []
    que.push(self) 
    until que.empty?
      node = que.shift
      if node.value == target_value 
        return node 
      end 
      que.concat(node.children) unless node.children.empty?
    end   
    return nil 
  end 
       
end