class Player
attr_accessor :human

  def initialize
    @human = true
  end

  def give_answer (ans = nil)
    if @human 
      answer = ans.split(' ')
      if answer.size != 4 
        return false
      else
        return answer
      end
    else
      #todo : IA
      #return %w(red blue white black)
    end
  end



end