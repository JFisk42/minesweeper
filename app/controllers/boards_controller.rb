class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    # @board = Board.find(params[:id])
    @board = Board.new
    @message = "just simple text for now thank you"
  end

  def new
    generate_board("a board for the ages", 10, 10, 10, "test@gmail.com")
  end

  def generate_board(name, height, width, mine_count, email)
    # logic for generating random board, uses xy object
    new_board = Board.new(name: name, height: height, width: width, mine_count: mine_count, email: email, created: Time.now)
    new_board.save
    
    #Generate rows now
    #for now assume all boards are under ~250 columns/rows
    # for each xyobject.height do 
    new_row = Row.new(board: new_board, row_index: 1, col_index: 1, row_content: "OOOOOOXOOO")
    new_row.save
  end
end
