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
      mine_locations = create_mine_locations  
      
      total_grid_iterator = 0
      board_grid = Array.new(@board.width) {Array.new(@board.height)}

      for column_index in 0..(@board.height-1) do
        
        row_iterator = 0
          
        while row_iterator < @board.width do
          
          if mine_locations.include? total_grid_iterator
            board_grid[column_index] << '💣' 
          else
            board_grid[column_index] << '⬜️' 
          end

          row_iterator = row_iterator + 1
          total_grid_iterator = total_grid_iterator + 1
        end
        
        combined_row = board_grid[column_index].join("") #row_index needs its own iterator, but also maybe db is just chill with extra long strings? need to investigate
        new_row = @board.rows.new(row_index: row_iterator, col_index: 1, row_content: combined_row) #col index is only used for width > 250ish, hardcode for now
        new_row.save
        # TODO Error handling
        # render :new, status: :unprocessable_entity unless new_row.save #need to make these transactions happen together, especially with multiple rows coming up
      end
    end

    def create_mine_locations 
      grid_area = @board.height * @board.width
      raise error, "illegal board" if @board.mine_count > grid_area
      
      mine_locations = []
      index = 0

      while index < @board.mine_count do 
        new_mine = rand(grid_area)
        unless mine_locations.include? new_mine
          mine_locations << new_mine
          index = index + 1
        end
      end

      mine_locations.sort #what if this was all that we saved in the db for each row, perf improvements?
    end

end
