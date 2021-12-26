class Ticket
  attr_reader :row_count, :column_count, :row_slot_count, :slots, :grid

  def initialize args = {}
    @row_count = args[:row_count] || 3
    @column_count = args[:column_count] || 9
    @row_slot_count = args[:row_slot_count] || 5
    @slots = generate_slots
    @grid = generate_grid
  end

  def show
    puts 'BINGO TICKET'
    grid.each { |row| puts row.join('   ') }
  end

  private

  # Generates 5 slots for each row
  def generate_slots
    Array.new(row_count) do
      (0..column_count-1).to_a.sample(row_slot_count)
    end
  end

  # Generates ticket grid according to slots
  def generate_grid
    Array.new(row_count) do |row_num|
      (0..column_count-1).map do |column_num|
        slots[row_num].include?(column_num) ? generate_number(column_num) : 'X'
      end
    end
  end

  # Generates random number for given column and remove generated value from possible values
  def generate_number column_num
    @possible_value ||= []
    @possible_value[column_num] ||=  (10*column_num...10*(column_num+1)).to_a.reject { |num| num == 0 }
    selected_value = @possible_value[column_num].sample
    @possible_value[column_num].delete(selected_value) 
    selected_value
  end
end
