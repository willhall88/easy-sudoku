require 'grid'

describe Grid do
  let(:puzzle){'015003002000100906270068430490002017501040380003905000900081040860070025037204600'}  
  let(:grid) {Grid.new(puzzle)}
  it "should have 81 key value pairs" do
    expect(grid.grid.keys.count).to eq 81
  end

  it "each grid cell should be an instance of the Cell class" do
    expect(grid.grid.values.first.class).to eq(Cell)
  end

  it "each row should have 9 cells" do
    expect(grid.rows.count).to eq 9
  end

  it 'should know that key 50 should be in the 6th row' do
    grid.grid["50"]=1
    expect(grid.rows[5][0]).to eq(1)
  end

  it "each column should have 9 cells" do
    expect(grid.columns.count).to eq 9
  end

  it 'should know that key 05 should be in the 6th col' do
    grid.grid["05"]=1
    expect(grid.columns[5][0]).to eq(1)
  end

  it 'should have 9 unique sectors each 3x3' do
    expect(grid.sectors.count).to eq 9
  end

  it'sector 6 to have permutations of 3,4,5 and 6,7,8' do
    expected = [3,4,5].product([6,7,8]).map {|array| array.join}
    expect(grid.sectors[5]).to eq expected
  end

  it 'should identify the other sector coordinates that 36 is in' do
    expected = [3,4,5].product([6,7,8]).map {|array| array.join}
    expect(grid.find_sector("36")).to eq expected
  end

  context ' solving a puzzle' do
    it 'should have an initialized grid that takes the puzzle as an argument' do
      expect(grid.rows[0][2].value).to eq(5)
    end

    it 'should take the first unsolved cell and subtract the other values in the row from 1..9' do
      expect(grid.cell_row("00")).to eq [1, 5, 3, 2]
    end

    it 'should take the first unsolved cell and subtract the other values in the column from 1..9' do
      expect(grid.cell_column("00")).to eq [2, 4, 5, 9, 8]
    end

    it 'should take the first unsolved cell and subtract the other values in the sector from 1..9' do
      expect(grid.cell_sector("00")).to eq [1, 5, 2, 7]
    end    

    it 'should take the first unsolved cell and subtract all unavailable options'do
      expect(grid.cell_solve("00")).to eq 6
    end

    it 'if only one number is available for cell, then it should place this value into the cell' do
      grid.cell_solve("00")
      expect(grid.grid["00"].value).to eq 6
    end






  end
end