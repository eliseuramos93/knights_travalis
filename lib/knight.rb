class Knight
  MOVES = [
    [1, 2], [1, -2], [-1, 2], [-1, -2],
    [2, 1], [2, -1], [-2, 1], [-2, -1]
  ].freeze

  @@places_traveled = []

  attr_reader :position, :parent

  def initialize(position, parent = nil)
    @position = position                  # => where the knight starts at board
    @parent = parent                      # => knight object w/ previous position for recursion
    @@places_traveled.push(@position)     # => store each movement to avoid repeated values in queue
  end 
   
  def valid_position?(position)
    position[0].between?(0, 7) && position[1].between?(0, 7)
  end 

  def add_children_to_queue
    MOVES.map {|move| [move[0] + @position[0], move[1] + @position[1]]}
         .keep_if { |new_position| valid_position?(new_position)}
         .reject { |new_position| @@places_traveled.include?(new_position) }
         .map {|new_position| Knight.new(new_position, parent = self)}  # => parents store travel history
  end 

  def show_parents(count = 0)
    return count if self.nil?
    count = @parent.show_parents(count +=1) unless @parent.nil?
    p @position
    count
  end
end 

def knight_moves(start_pos, end_pos)
  queue = []
  knight = Knight.new(start_pos, nil)
  until knight.position == end_pos
    knight.add_children_to_queue.each { |child| queue.push(child) }
    knight = queue.shift
  end 
  puts "You've made it in #{knight.show_parents} turns!"
end 

