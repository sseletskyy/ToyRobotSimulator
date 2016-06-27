class ToyRobot

    DIRECTIONS = %w(NORTH EAST SOUTH WEST)
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
        @y += 1 if valid_place_args?(@x, @y+1, @direction)
    end

    private
    def valid_place_args?(x, y, direction)
        return false unless x >= 0 && x <= @max_pos
        return false unless y >= 0 && y <= @max_pos
        return false unless DIRECTIONS.index(direction)
        true
    rescue ArgumentError
        false 
    end
end