class Knight
  attr_accessor :position, :children, :parent, :visited_nodes
  def initialize(position = [0, 0], parent = nil)
    @position = position
    @children = []
    @parent = parent
    
  end
end

class Board
  attr_accessor :board, :knight
  def initialize(position)
    @board = make_board
    @knight = set_knight(position)
    @visited_positions = [@knight.position]
    @queue = []
  end
  
  def make_board
    
    board = []
    (0..7).each do |x|
      (0..7).each do |y|
      board << [x, y]
      end
    end
    board
  end

  def set_knight(position)
    index = @board.index(position)
    @board[index] = Knight.new(position)
    knight = @board[index]
    return knight
  end

  def find_knight
    @board.each_with_index do |num, idx|
      return num if num.class == Knight
    end
    return 
  end

  def make_children(knight)
    knight.children = possible_moves(knight.position)
    @visited_positions += knight.children
  end

  def possible_moves(position)
    moves = []
    move_1 = [position[0] + 1, position[1] + 2]
    moves << move_1
    move_2 = [position[0] + 2, position[1] + 1]
    moves << move_2
    move_3 = [position[0] + 2, position[1] - 1]
    moves << move_3
    move_4 = [position[0] + 1, position[1] - 2]
    moves << move_4
    move_5 = [position[0] - 1, position[1] - 2]
    moves << move_5
    move_6 = [position[0] - 2, position[1] - 1]
    moves << move_6
    move_7 = [position[0] - 2, position[1] + 1]
    moves << move_7
    move_8 = [position[0] - 1, position[1] + 2]
    moves << move_8

    return moves.select {|move| valid_move?(move)}
    
  end

  def add_knights(knight)
    knight.children.each_with_index do |position, idx|
      if @board.include?(position)
            spot = @board.index(position)
            @board[spot] = Knight.new(position, knight)
            @queue << @board[spot]
      end
       end
  end

  def check_destination(ending)
    path = []
    @board.each_with_index do |position, idx|
      if position.class == Knight
        if position.position == ending
            return position
        end
      end
    end
    return nil
  end

  def knight_path(knight)
    path = []
    current_knight = knight
    while current_knight.parent
      path << current_knight.position
      current_knight = current_knight.parent
    end
    final_path = (path + [@knight.position]).reverse
    return "You made it in #{final_path.length} moves. Here's your path: #{final_path}"
  end

  def move_knight(ending)
    start = @knight   #start with our first knight
    return "You're already there!" if start.position == ending
         #queue has actual first knight in there
    @queue = [start]
    while !@queue.empty?
    current_ele = @queue.first
    children = make_children(current_ele) #makes array of children for current knight
    next_moves = possible_moves(current_ele.position) 
    add_knights(current_ele) #add knight nodes from the current_knight's children into @board and into the queue
    if check_destination(ending) 
    ending_knight = check_destination(ending)
    return knight_path(ending_knight)
    end
    @queue.shift
    end
   
  end

  def destination?(position, destination)
    return true if position == destination
    return false
  end

  def valid_move?(move)
    return false if move[0] < 0 || move[0] > 7 || move[1] < 0 || move[1] > 7 || @visited_positions.include?(move)
    return true
  end
  
end

board = Board.new([3, 3])
p board.move_knight([4, 3])













