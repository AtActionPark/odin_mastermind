class Game
  require_relative 'Player'

  attr_accessor :code
  attr_reader :nb_of_hits
  attr_reader :nb_of_colors
  attr_reader :continue

  @colors

  def initialize
    @colors = %w(blue green red white black yellow)
    @nb_of_hits = 0
    @nb_of_colors = 0
    @continue = true
    random_code
  end

  def random_code
    @code = []
    4.times do 
      @code << @colors.sample
    end
  end

  def get_random_code
    r = []
    4.times do 
      r << @colors.sample
    end
    return r
  end

  def answer ans
    temp_code = @code.clone

    @nb_of_hits = 0
    @nb_of_colors = 0
    #check for hits
    4.times do |i|
      if ans[i] == temp_code[i]
        @nb_of_hits+=1
        temp_code[i] = ""
      end
    end
    #check for misplaced colors
    4.times do |i|
      if temp_code.include?(ans[i])
        @nb_of_colors+=1
        temp_code[temp_code.index(ans[i])] = ""
      end
    end
  end

  def check_state turn
    if @nb_of_hits == 4 || turn >=4
      @continue = false
    end
  end

end

game = Game.new
player = Player.new
turn = 1

puts "Mastermind : Do you want to guess (g) or give a code (c)"
user = gets.chomp 
while user != "c" && user != "g"
  puts "Do you want to guess (g) or give a code (c)"
  user = gets.chomp 
end

if user == 'c'
  puts "Please input the code : 4 colors separated by spaces (blue, green, red, white, black or yellow) "
  new_code = gets.chomp
  game.code = new_code.split(" ")
end

while game.continue
  puts ""
  puts "Turn #{turn}"

  if(user == 'g')
    puts 'Please input 4 colors separated by spaces'
    answer = player.give_answer(gets.chomp)
    while answer == false
      puts 'Please input 4 colors'
      answer = player.give_answer(gets.chomp) 
    end
    puts "your answer is " + answer.to_s
  else 
    player.human = false
    answer = game.get_random_code #replace with bottom line when IA implemented
    #answer = player.give_answer()  
    puts "The computer answer is " + answer.to_s
  end

  #puts "the answer is " + game.code.to_s
  game.answer(answer)
  puts " Hits : #{game.nb_of_hits}, Misplaced colors : #{game.nb_of_colors}"
  game.check_state(turn)
  turn +=1
end

if turn >=4
  puts "The coder won"
else
  puts "The guesser won"
end
