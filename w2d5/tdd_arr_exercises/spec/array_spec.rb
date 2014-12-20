require "rspec"
require "my_arr"
require "towers_of_hanoi"

describe Array do
  describe '#my_uniq' do
    it "returns original array if size <= 1" do
      expect([].my_uniq).to eq([])
      expect([1].my_uniq).to eq([1])
    end

    it "removes dups from array size greater than 1" do
      test_arr = [1, 2, 1, 3, 3]
      expect(test_arr.my_uniq).to eq([1, 2, 3])
    end

    it "returns new array" do
      test_arr_size_1 = [1]
      expect(test_arr_size_1.my_uniq.object_id).to_not eq(test_arr_size_1.object_id)
    end
  end

  describe '#two_sum' do
    it "returns index pairs of numbers that sum to 0 in the calling array" do
      test_arr = [-1, 0, 2, -2, 1]
      expect(test_arr.two_sum).to eq([[0, 4], [2, 3]])
    end

    it "returns an empty array if called on an empty array" do
      test_arr = []
      expect(test_arr.two_sum).to eq([])
    end

    it "returns an empty array if called on an array with no matches" do
      test_arr = [1, 0, 1, 3, 9]
      expect(test_arr.two_sum).to eq([])
    end
  end
end

describe 'my_transpose' do
  # it "returns copy of self if called on 1-d array of size less than 2" do
  #   expect(my_transpose([])).to eq([])
  #   expect(my_transpose([1])).to eq([1])
  #   test_arr = [1]
  #   expect(my_transpose(test_arr).object_id).to_not eq(test_arr.object_id)
  # end

  let(:test_arr) {[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]}
  let(:expected_result) {[
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]}

  it "doesn't modify the original array" do
    expect(my_transpose(test_arr).object_id).to_not eq(test_arr.object_id)
  end

  it "returns transpose of 2-d array" do
    expect(my_transpose(test_arr)).to eq(expected_result)
  end

end

describe Tower do
  subject(:tower) { Tower.new }

  it "initializes a non-empty leftmost tower and two empty other towers" do
    expect(tower.stacks[1]).to_not be_empty
    expect(tower.stacks[2]).to be_empty
    expect(tower.stacks[3]).to be_empty
    expect(tower.stacks[4]).to be_nil
  end

  it "initializes win_stack same as first tower" do
    expect(tower.win_stack).to eq(tower.stacks[1])
  end

  describe '#move_disk' do

    it "allows the user to move the first disk to an empty tower,
    and removes the disk from its original tower" do
      length = tower.stacks[1].length
      expect(tower.move_disk(1, 3)).to be_truthy
      expect(tower.stacks[3]).to_not be_empty
      expect(tower.stacks[1].length).to eq(length - 1)
    end

    it "doesn't allow user to put larger disk on top of smaller disk" do
      tower.move_disk(1, 3)
      tower.move_disk(1, 2)
      expect do
        tower.move_disk(1, 3)
      end.to raise_error(RuntimeError)
    end
  end

  describe '#over?' do

    it "returns false on initialization" do
      expect(tower).to_not be_over
    end

  end
end
