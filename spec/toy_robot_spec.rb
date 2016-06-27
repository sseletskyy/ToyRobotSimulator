require_relative '../toy_robot'
RSpec.describe ToyRobot do
    let(:toy) {ToyRobot.new}
    context 'REPORT' do
        it 'should return empty string when the robot is not placed yet' do
            expect(toy.report).to eq("")
        end
    end

    def place
        @x = @y = 0
        @direction = 'NORTH'
    end
    context 'valid_place_args?' do
        [
            {params:['','',''], expected: false},
            {params:['!','',''], expected: false},
            {params:['','!',''], expected: false},
            {params:['5','1','NORTH'], expected: false},
            {params:['-1','1','NORTH'], expected: false},
            {params:['1','5','NORTH'], expected: false},
            {params:['1','-1','NORTH'], expected: false},
            {params:['1','1','N'], expected: false},
            {params:['1','1','NORTH'], expected: false},
            {params:[1,1,'NORTH'], expected: true},
            {params:[1,1,'EAST'], expected: true},
            {params:[1,1,'SOUTH'], expected: true},
            {params:[1,1,'WEST'], expected: true}
        ]
        .each do |option|
            it "check option #{option[:params].to_s} expected #{option[:expected]}" do
               expect(toy.send('valid_place_args?', *option[:params])).to eq(option[:expected])  
            end
        end

    end

    context 'PLACE' do
        context 'without arguments' do
            it 'should not change position' do
                toy.place
                expect(toy.report).to eq("")
            end
        end
    end
    context 'with correct arguments' do
        it 'should change the position' do
            toy.place(1,1,'NORTH')
            expect(toy.report).to eq("1,1,NORTH") 

            toy.place(2,2,'SOUTH')    
            expect(toy.report).to eq("2,2,SOUTH") 
        end
    end
    context 'with incorrect args' do
        it 'should not change the position' do
            # case 1 
            report_str = toy.report
            toy.place("")
            expect(toy.report).to eq(report_str)

            # case 2 = incorrect first arg
            toy.place(2,2,'SOUTH') # set correct    
            report_str = toy.report
            toy.place(-5, 4, 'NORTH') # set incorrect
            expect(toy.report).to eq(report_str)

            # case 3 = incorrect second arg
            toy.place(2,2,'SOUTH') # set correct    
            report_str = toy.report
            toy.place(3, -3, 'SOUTH') # set incorrect
            expect(toy.report).to eq(report_str)

        end
    end
    context 'MOVE' do
        context 'when position is NORTH' do
            it 'should move unless the border' do
                y = 3
                toy.place(0, y, 'NORTH')
                
                toy.move
                y += 1
                expect(toy.report).to eq("0,#{y},NORTH")
                # last move beyond the border
                toy.move
                # no increment for y
                expect(toy.report).to eq("0,#{y},NORTH")
            end
        end
    end
end