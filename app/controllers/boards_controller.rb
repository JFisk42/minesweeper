class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
    @boards = Board.all.last(10)
  end

  def new
    @board = Board.new
    # generate_board("a board for the ages", 10, 10, 10, "test@gmail.com")
  end

  # bundle exec rdbg --open -n -c -- bundle exec rails s

  def create
    # @board = Board.new(name: "a board for the ages", height: 10, width: 10, mine_count: 10, email: "test@gmail.com")
    @board = Board.new(board_params)

    #for whatever reason it's not passing in the parameters and isn't bubbling up error messages

    if @board.save
      generate_board
      redirect_to @board
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def board_params
      params.require(:board).permit(:name, :height, :width, :mine_count, :email)
    end

    def generate_board
      grid_area = @board.height * @board.width
      mine_place = []
      iterator = 0
      
      while iterator < @board.mine_count do #don't need while, switch to for/each
        new_mine = rand(grid_area)
        unless mine_place.include? new_mine
          mine_place << new_mine
          iterator = iterator + 1
        end
      end

      mine_place.sort!
      outer_iterator = 0

      for index in 0..@board.height do
        
        inner_iterator = 0
        board_grid = []
          
        while inner_iterator < @board.width do #need to check for off by one
          
          if mine_place.include? outer_iterator
            board_grid << '💣' 
          else
            board_grid << '⬜️' 
          end

          inner_iterator = inner_iterator + 1
          outer_iterator = outer_iterator + 1
        end

        combined_row = board_grid.join("")
        # new_row = Row.new(board: @board, row_index: inner_iterator, col_index: 1, row_content: combined_row) #col index is only used for width > 250ish, hardcode for now
        new_row = @board.rows.new(row_index: inner_iterator, col_index: 1, row_content: combined_row) #col index is only used for width > 250ish, hardcode for now
        new_row.save
        # render :new, status: :unprocessable_entity unless new_row.save #need to make these transactions happen together, especially with multiple rows coming up
      end
            
    end
end
