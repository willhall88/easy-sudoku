require_relative 'cell'

class Grid
  attr_reader :grid


  def initialize(puzzle)
    @grid = {}
    # puts puzzle.chars.inspect
    (0..8).each{|row_num| (0..8).each{|col_num| @grid["#{row_num}#{col_num}"] = Cell.new}}
     @grid.keys.each_with_index {|key,index| @grid[key].value = puzzle.chars[index].to_i }
    # puts grid
  end


  def rows
    grid.values.each_slice(9).to_a
  end

  def columns
    rows.transpose
  end

  def sectors
    [*0..8].each_slice(3).map {|slice1| [*0..8].each_slice(3).map{|slice2| slice1.product(slice2).map{|array| array.join}}}.flatten(1)
  end

  def find_sector(coordinates)
    sectors.select {|sector| sector.include?(coordinates)}.flatten
  end

  def cell_row(coordinates)
    row_index = coordinates.split[0].to_i
    range = [*1..9]
    rows[row_index].map {|cell| cell.value} - [0]
  end

  def cell_column(coordinates)
    column_index = coordinates.split[1].to_i
    range = [*1..9]
    columns[column_index].map {|cell| cell.value} - [0]
  end

end