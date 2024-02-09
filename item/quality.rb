
class Quality
  MIN_VALUE = 0
  MAX_VALUE = 50
  def initialize(value)
    @value = value
  end
  
  def value
    @value.clamp(MIN_VALUE ,MAX_VALUE )
  end

  def increase_value
    @value += 1
  end
  
  def decrease_value
    @value -= 1
  end
end

