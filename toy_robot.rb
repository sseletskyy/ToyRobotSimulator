class ToyRobot

    DIRECTIONS = %w(NORTH EAST SOUTH WEST)
    SIGNS = %w(+ -)
    def initialize
        @dimension = 5
        @max_pos = @dimension - 1
    end
    def report
        return "" unless @direction
        "#{@x},#{@y},#{@direction}"
    end

    def place(x = nil, y = nil, direction = nil)
        x = x.to_i
        y = y.to_i
        direction = direction.to_s
        
        return unless valid_place_args?(x, y, direction)
        
        @x = x
        @y = y
        @direction = direction
    end

    def move
        send("move_#{@direction.downcase}") if @direction
    end

    def left
        rotate('-')
    end

    def right
        rotate('+')
    end

    def rotate(sign)
        return unless ( @direction && SIGNS.index(sign) )
        direction_index = DIRECTIONS.index(@direction)
        direction_index = direction_index.send(sign, 1) # +1 or -1
        direction_index %= DIRECTIONS.count
        @direction = DIRECTIONS[direction_index]        
    end

    private

    def move_north
        @y += 1 if valid_place_args?(@x, @y+1, @direction)
    end

    def move_east
        @x += 1 if valid_place_args?(@x+1, @y, @direction)
    end

    def move_south
        @y -= 1 if valid_place_args?(@x, @y-1, @direction)
    end

    def move_west
        @x -= 1 if valid_place_args?(@x-1, @y, @direction)
    end

    def valid_place_args?(x, y, direction)
        return false unless x >= 0 && x <= @max_pos
        return false unless y >= 0 && y <= @max_pos
        return false unless DIRECTIONS.index(direction)
        true
    rescue ArgumentError
        false
    end
end