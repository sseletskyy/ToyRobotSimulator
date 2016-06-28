require_relative 'toy_robot'
require 'io/console'
class Game
    def initialize
        @toy = ToyRobot.new
        main        
    end
    def main
        ARGF.each do |line|
            result = @toy.parse_line line
            puts result if result.class == String
        end     
    rescue Interrupt => e
        puts "\n\nGame over :)"
    end
    
end
Game.new
