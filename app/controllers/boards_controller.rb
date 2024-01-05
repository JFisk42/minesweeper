class BoardsController < ApplicationController

  def index
    @boards = Board.all.last(10)
  end

  def all
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      generate_board(@board)
      redirect_to @board
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def board_params
      params.require(:board).permit(:name, :height, :width, :mine_count, :email)
    end

    # Creates a series of row objects by first generating a 2D array of the board. 
    # Adds in randomized mines according to the number specified.
    #
    # @param board [Board] model of the board the grid will be generated for
    #
    # @renders 422 Unprocessable Entity if the save for a row object fails. 
    def generate_board(board)
      mine_locations = create_mine_locations(board.height * board.width, board.mine_count)
      
      total_grid_iterator = 0
      board_grid = Array.new(board.height) {Array.new(board.width)}

      for column_index in 0..(board.height-1) do
        
        row_iterator = 0
          
        while row_iterator < board.width do
          
          if mine_locations.include? total_grid_iterator
            board_grid[column_index] << '💣' 
          else
            board_grid[column_index] << '⬜️' 
          end

          row_iterator = row_iterator + 1
          total_grid_iterator = total_grid_iterator + 1
        end
        
        combined_row = board_grid[column_index].join("") 
        new_row = board.rows.new(row_index: row_iterator, row_content: combined_row) 
        unless new_row.save
          render :new, status: :unprocessable_entity 
        end
      end
    end

    # Randomly generates the locations for the number of mines specified.
    # 
    # @param grid_area [Integer] the area of the board
    # @param mine_count [Integer] the number of mines to fit in the grid area
    #
    # @raises ArgumentError if the number of mines is larger than the overall grid area.
    # @return [Array] returns an array representing mine locations in ascending order.
    def create_mine_locations(grid_area, mine_count)
      raise ArgumentError, "illegal board" if mine_count > grid_area
      
      mine_locations = []
      index = 0

      while index < @board.mine_count do 
        new_mine = rand(grid_area)
        unless mine_locations.include? new_mine
          mine_locations << new_mine
          index = index + 1
        end
      end

      mine_locations.sort
    end
end