class Space
    attr_accessor :valid_spaces, :position #:x_coord, :y_coord

    def initialize(x, y)
        @position = [x,y]
        @valid_spaces = []
        @history = []
    end
end

class Board
    attr_accessor :spaces

    def initialize()
        @spaces = Array.new(8){Array.new(8)}
    end

    def populate_board()
        x = 0

        #Fill the board with spaces, giving each a coordinate
        while x < 8 do
            y = 0
            while y < 8 do
                a_space = Space.new(x, y)
                @spaces[x][y] = a_space
                y+=1
            end
            x+=1
        end
    end

    def determine_moves(space)
        template = [[2,1],[2,-1],[1,2],[1,-2],[-2,1],[-2,-1],[-1,2],[-1,-2]]
        temp = []

        space.valid_spaces = template
        space.valid_spaces.each do |node|
            node[0] = node[0] + space.position[0]
            node[1] = node[1] + space.position[1]
        end

        space.valid_spaces.each do |x|
            temp = temp.append(x.reject {|num| num < 0 || num >= 8})
        end
        space.valid_spaces = temp.select {|x|x.length == 2}
    end

    def assign_valid_moves
        #Loop through the board and determine the valid moves that each piece can make
        x = 0
        while x < 8 do
            y = 0
            while y < 8 do
                determine_moves(@spaces[x][y])
                y+=1
            end
            x+=1
        end
    end

    def get_node(pos)
        x = 0

        while x < 8 do
            y = 0
            while y < 8 do
                if pos == @spaces[x][y].position
                    node = @spaces[x][y]
                end
                y+=1
            end
            x+=1
        end
        node
    end

    def move_knight(start, dest)

        start_space = get_node(start)

        queue = []
        until start_space.position == dest
            start_space.valid_spaces.each do |child|
                queue.push(child)
                p child
            end
            start_space = get_node(queue.shift)
        end
        p history
    end
end
my_board = Board.new()
my_board.populate_board()
my_board.assign_valid_moves()
my_board.move_knight([3,3],[4,3])
#visited = []
        #q.append(get_node(start))

        #while(!q.empty?)
            #node = q.pop()

            #pos = node.position
            #dist = node.dist

            #if pos == dest
                #return dist
           ##if !visited.include?(pos)
                #visited.append(pos)
                #node.valid_spaces.each do |x|
                    #q.push(get_node(x))
                #end
           # end
        #end