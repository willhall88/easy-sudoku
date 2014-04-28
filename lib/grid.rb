require_relative 'cell'

class Grid
  attr_accessor :grid


  def initialize(puzzle)
    @grid = {}
    (0..8).each{|row_num| (0..8).each{|col_num| @grid["#{row_num}#{col_num}"] = Cell.new}}
     @grid.keys.each_with_index {|key,index| @grid[key].value = puzzle.chars[index].to_i }
    @initial_grid=@grid.dup
  end

    SIZE = 81

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
    row_index = coordinates.chars.first.to_i
    rows[row_index].map {|cell| cell.value} - [0]
  end

  def cell_column(coordinates)
    column_index = coordinates.chars.last.to_i
    columns[column_index].map {|cell| cell.value} - [0]
  end

  def cell_sector(coordinates)
    find_sector(coordinates).map {|key| grid[key].value } - [0]
  end

  def cell_solve(coordinates)
    if grid[coordinates].value == 0
      range = [*1..9] - cell_row(coordinates) - cell_column(coordinates) - cell_sector(coordinates) - [0]
      grid[coordinates].value = (range.first ) if range.length == 1 
    end
    return range
  end

  def solved?
    !grid.values.map {|cell| cell.value }.include?(0)
  end

  def solve(current_grid)
    outstanding_before, looping = SIZE, false
    while !solved? && !looping
      current_grid.keys.each {|coordinates| cell_solve(coordinates)}
      outstanding = current_grid.values.select {|cell| cell.value != 0}.count
      looping = outstanding_before == outstanding
      outstanding_before = outstanding
    end
    # puts @initial_grid.values.map {|cell| cell.value}.each_slice(9) {|slice| puts slice.inspect}
    # puts grid.values.map {|cell| cell.value}.each_slice(9) {|slice| puts slice.inspect}
    try_harder if !solved? 
  end

  def blank_cell(copy_grid)
    copy_grid.key(copy_grid.values.find {|cell| cell.value == 0})
  end

  def replicate(copy_grid)
    @new_grid = copy_grid.dup
  end

  def try_harder
    replicate(grid)
    new_coord=blank_cell(@new_grid)
    cell_solve(new_coord).each do |option| 
      @new_grid[new_coord].value=option
      
      solve(@new_grid)
    end


  end

end


