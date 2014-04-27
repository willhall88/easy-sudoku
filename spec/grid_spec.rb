require 'grid'

describe Grid do
  let(:puzzle) {Grid.new}
  it "should have 81 key value pairs" do
    expect(puzzle.grid.keys.count).to eq 81
  end

  it "each grid cell should be an instance of the Cell class" do
    expect(puzzle.grid.values.first.class).to eq(Cell)
  end

  it "each row should have 9 cells" do
    expect(puzzle.rows.count).to eq 9
  end

  it 'should know that key 50 should be in the 6th row' do
    puzzle.grid["50"]=1
    expect(puzzle.rows[5][0][1]).to eq(1)
  end

  it "each column should have 9 cells" do
    expect(puzzle.columns.count).to eq 9
  end

  it 'should know that key 05 should be in the 6th col' do
    puzzle.grid["05"]=1
    expect(puzzle.columns[5][0][1]).to eq(1)
  end

  it 'should have 9 unique sectors each 3x3' do
    expect(puzzle.sectors.count).to eq 9
  end

end