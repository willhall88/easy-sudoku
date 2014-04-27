require_relative 'cell'

class Grid
  attr_reader :grid


  def initialize
    @grid = {}
    (0..8).each{|row_num| (0..8).each{|col_num| @grid["#{row_num}#{col_num}"] = Cell.new}}
  end


  def rows
    grid.to_a.each_slice(9).to_a
  end

  def columns
    rows.transpose
  end

  def sectors
    [*0..8].each_slice(3).map {|slice1| [*0..8].each_slice(3).map{|slice2| slice1.product(slice2).map{|array| array.join}}}.flatten(1)
  end




end