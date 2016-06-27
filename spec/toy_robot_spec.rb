require_relative '../toy_robot'
RSpec.describe ToyRobot do
    let(:toy) {ToyRobot.new}
    context 'REPORT' do
        it 'should return empty string when the robot is not placed yet' do
            expect(toy.report).to eq("")
        end
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
            {params:[1,1,'north'], expected: false},
            {params:[1,1,'east'], expected: false},
            {params:[1,1,'south'], expected: false},
            {params:[1,1,'west'], expected: false},
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
        context 'when position is EAST' do
            it 'should move unless the border' do
                x = 3
                toy.place(x, 0, 'EAST')
                
                toy.move
                x += 1
                expect(toy.report).to eq("#{x},0,EAST")
                # last move beyond the border
                toy.move
                # no increment for x
                expect(toy.report).to eq("#{x},0,EAST")
            end
        end
        context 'when position is SOUTH' do
            it 'should move unless the border' do
                y = 1
                toy.place(0, y, 'SOUTH')
                
                toy.move
                y -= 1
                expect(toy.report).to eq("0,#{y},SOUTH")
                # last move beyond the border
                toy.move
                # no increment for y
                expect(toy.report).to eq("0,#{y},SOUTH")
            end
        end
        context 'when position is WEST' do
            it 'should move unless the border' do
                x = 1
                toy.place(x, 0, 'WEST')
                
                toy.move
                x -= 1
                expect(toy.report).to eq("#{x},0,WEST")
                # last move beyond the border
                toy.move
                # no increment for x
                expect(toy.report).to eq("#{x},0,WEST")
            end
        end
    end
    context 'LEFT' do
        it 'should change direction CCW' do
            toy.place(0,0,'NORTH')
            toy.left
            expect(toy.report).to eq('0,0,WEST')

            toy.left
            expect(toy.report).to eq('0,0,SOUTH')

            toy.left
            expect(toy.report).to eq('0,0,EAST')

            toy.left
            expect(toy.report).to eq('0,0,NORTH')
        end
    end
    context 'RIGHT' do
        it 'should change direction CW' do
            toy.place(0,0,'NORTH')
            toy.right
            expect(toy.report).to eq('0,0,EAST')

            toy.right
            expect(toy.report).to eq('0,0,SOUTH')

            toy.right
            expect(toy.report).to eq('0,0,WEST')

            toy.right
            expect(toy.report).to eq('0,0,NORTH')
        end
    end
    context 'ROTATE' do
        it 'should not change direction in direction is not set' do
            report_str = toy.report
            expect(report_str).to eq("")
            toy.rotate('+')
            expect(toy.report).to eq(report_str)
        end
        it 'should not change direction in case of incorrect sign' do
            toy.place(2,2,'NORTH')
            report_str = toy.report
            puts "report_str=#{report_str}" 
            toy.rotate('&&')
            expect(toy.report).to eq(report_str)
        end

    end
end