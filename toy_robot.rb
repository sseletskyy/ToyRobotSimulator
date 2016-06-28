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
        
        return false unless valid_place_args?(x, y, direction)
        
        @x = x
        @y = y
        @direction = direction
        true
    end

    def move
        return false unless @direction
        send("move_#{@direction.downcase}") 
    end

    def left
        rotate('-')
    end

    def right
        rotate('+')
    end

    def rotate(sign)
        return false unless ( @direction && SIGNS.index(sign) )
        direction_index = DIRECTIONS.index(@direction)
        direction_index = direction_index.send(sign, 1) # +1 or -1
        direction_index %= DIRECTIONS.count
        @direction = DIRECTIONS[direction_index]  
        true      
    end

    def parse_line(line)
        command, *args = line.split(' ')
        command.downcase!
        case command
        when 'place'
            args = args.to_a.join.split(',').map(&:strip)
            return place(*args)
        when 'move', 'left', 'right', 'report'
            return send(command)
        end
        false 
    end

    private

    def move_north
        return false unless valid_place_args?(@x, @y+1, @direction)
        @y += 1
        true
    end

    def move_east
        return false unless valid_place_args?(@x+1, @y, @direction)
        @x += 1
        true
    end

    def move_south
        return false unless valid_place_args?(@x, @y-1, @direction)
        @y -= 1
        true
    end

    def move_west
        return false unless valid_place_args?(@x-1, @y, @direction)
        @x -= 1
        true
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