require_relative 'toy_robot'
require 'io/console'
class Game
    def initialize
        @toy = ToyRobot.new
        main        
    end
    def main
        ARGF.each do |line|
            @toy.parse_line line
        end     
    end
    
end
Game.new
