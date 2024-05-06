

class Player
    attr_accessor :sign, :current_player

    def initialize(sign)
        @sign = sign
    end

    def get_move(board, player, game)
        @move = gets.chomp
        ##Checks for valid coords input 'num num'
        while not check_input(@move, board, player)
            puts "Enter valid coords:"
            @move = gets.chomp
        end

        game.update_board( @move, player)

    end

    def check_input(move, board, player)
        #Check for values not '[0-2] [0-2]'
        if not (/[0-2][\s][0-2]/).match(move)
            return false
        else
            #temp to compare move in array form
            temp = move.split(' ')

            #Check the move will be on a ' ' cell and not an occupied one
            if (/[\s]/).match(board[temp[0].to_i][temp[1].to_i])
                @move = move.split(' ')
                return move.split(' ')
            else
                return false
            end
        end
    end


end

class GameBoard
    attr_accessor :board
    WIN_CONDITIONS =   [[[0, 0],[0, 1],[0, 2]],     #Check top row
                        [[1, 0],[1, 1],[1, 2]],     #Check middle row
                        [[2, 0],[2, 1],[2, 0]],     #Check bottom row
                        [[0, 0],[1, 0],[2, 0]],     #Check left col
                        [[0, 1],[1, 1],[2, 1]],     #Check middle col
                        [[0, 2],[1, 2],[2, 2]],     #Check right col
                        [[0, 0],[1, 1],[2, 2]],     #Check diag left to right
                        [[2, 0],[1, 1],[0, 2]]]     #Check diag right to left

    def initialize
        @board = Array.new(3){Array.new(3," ")}
        @current_player = "x"
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

    def update_board(move, player)
        @move_row = move[0].to_i
        @move_col = move[1].to_i

        @board[@move_row][@move_col] = player
    end

    def game_over
        WIN_CONDITIONS.each do |condition|
            cells = condition.map {|row, col| @board[row][col]}
            return true if cells.uniq.length == 1 && cells[0] != " "
        end
       
        return true if @board.all? {|row| row.none?{|cell| cell == " "} }
        
        false
    end
end

class GameController

    def initialize
        @game = GameBoard.new()
        @x_player = Player.new('x')
        @o_player = Player.new('o')
        @current_player = 'x'
        @game.display_board
        clock()
    end

    def clock
        while not @game.game_over
            if @current_player == 'x'
                @x_player.get_move(@game.board, @x_player.sign, @game)
                @current_player = 'o'
            else
                @o_player.get_move(@game.board, @o_player.sign, @game)
                @current_player = 'x'
            end
            @game.display_board
        end
    end


end


GameController.new()






