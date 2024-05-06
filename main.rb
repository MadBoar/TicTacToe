class Player
    attr_accessor :sign

    def initialize(sign)
        @sign = sign
    end

    def get_move
        @move = gets.chomp
        ##Checks for valid coords input 'num num'
        while not check_input(@move)
            puts "Enter valid coords:"
            @move = gets.chomp
        end

        p game.board

        ##Checks for valid move (not occupied)
        # while not illegal_move?(board, @move)

        # end

    end

    def check_input(move)
        
        if not (/[\d][\s][\d]/).match(move)
            return false
        else
            @move = move.split(' ')
            return move.split(' ')
        end

    end

    def illegal_move?()

    end


end

class GameBoard
    attr_accessor :board

    def initialize
        @board = Array.new(3){Array.new(3," ")}
    end

    def display_board
        system "clear"
        puts"   0 1 2 "
        board.each.with_index do |row, index| 
            puts "#{index}: #{row.join("|")}"
            if index < 2 then puts "   -----" end
        end
        puts ""
    end

    def update_board(board_array, move, player)
        @move_row = move[0]
        @move_col = move[1]

        @board[@move_row][@move_col] = player
    end
end

game = GameBoard.new()
x_player = Player.new('x')
o_player = Player.new('o')


game.update_board(game.board, [1, 0], x_player.sign)
game.display_board

x_player.get_move


