class Corrector
  def correct_name(name)
    if name.length > 10
      name[0...10].capitalize
    else
      name.capitalize
    end
  end
end
