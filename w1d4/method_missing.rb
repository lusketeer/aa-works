class Cat
  def say(anything)
    puts anything
  end

  def method_missing(method_name)
    method_name = method_name.to_s
    if method_name.start_with?("say")
      text = method_name[("say_").length..-1]
      say(text)
    else
      super
    end
  end
end
