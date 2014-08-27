class SimpleNameGenerator
  def initialize(size=16)
    @size = (size + 1) / 2
  end

  def next
    SecureRandom.hex(@size).upcase
  end
end