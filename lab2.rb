#Lab 2 : Ruby practice : Sierra Flynn, Lab 12-2 W
# Part1: Hello World
class HelloWorldClass
    def initialize(name)
       @name = name.capitalize
    end
    def sayHi
        puts "Hello #{@name}!" #write variable to screen
    end
end
hello = HelloWorldClass.new("Sierra")
hello.sayHi

#----------------------------------------------------------------------
#Part 2.a.
def palindrome?(string)
    fw = string.downcase.gsub(/\W+/, '') 
#downcase and delete any non-characters
    bw = fw.reverse
    if fw == bw
	#return true
	puts "true"
    else
	#return false
	puts "false"
    end
end
palindrome?("A man, a plan, a canal -- Panama")  # => true
palindrome?("Madam, I'm Adam!")                  # => true
palindrome?("Abracadabra")                       # => false (nil is also ok)

#----------------------------------------------------------------------
#Part 2.b.
def count_words(string)
    hash1 = {}
    string.downcase.scan(/\b+(\w+)\b+/).each do |word| 
    #save words to 'word'
    if hash1[word].nil? then #check if hash contains this word
	hash1[word] = 1 #if not, set value to 1
    else
        hash1[word] += 1 #if key already exists, add 1 to value
    end
end
puts hash1
end
count_words("A man, a plan, a canal -- Panama")
# => {'a' => 3, 'man' => 1, 'canal' => 1, 'panama' => 1, 'plan' => 1}
count_words "Doo bee doo bee doo"
# => {'doo' => 3, 'bee' => 2}
#----------------------------------------------------------------------
#Part 3.a.
class WrongNumberOfPlayersError <  StandardError ; end
class NoSuchStrategyError <  StandardError ; end

def rps_game_winner(game)
    #raise error if number players != 2
    raise WrongNumberOfPlayersError unless game.length == 2
    #raise error if player uses bad strategy
    strategy = /^(r|R|s|S|p|P)$/
    raise NoSuchStrategyError unless 
	game[0][1] =~ strategy && game[1][1] =~ strategy
    #R beats S, S beats P, P beats R
    if game[0][1].downcase == "r"
         if game[1][1] =~ /^(r|R|s|S)$/
         #if game[1][1].downcase == "r" || game[1][1].downcase == "s"
		winner = game[0][0]
		winningplay = game[0][1]
	  else 
		winner = game[1][0]
		winningplay = game[1][1]
          end
    elsif game[0][1].downcase == "s"
         if game[1][1] =~ /^(p|P|s|S)$/
	#if game[1][1].downcase == "s" || game[1][1].downcase == "p"
		winner = game[0][0]
		winningplay = game[0][1]
	  else 
		winner = game[1][0]
		winningplay = game[1][1]
	  end
    else #if game[0][1] == "P" | "p"
          if game[1][1] =~ /^(r|R|p|P)$/
         #if game[1][1].downcase == "p" || game[1][1].downcase == "r"
		winner = game[0][0]
		winningplay = game[0][1]
	  else 
		winner = game[1][0] 
		winningplay = game[1][1]
	  end
    end
return [winner, winningplay]
end
p rps_game_winner([["Armando","p"],["Dave","S"]])
p rps_game_winner([["Armando","s"],["Dave","S"]])
p rps_game_winner([["Armando","s"],["Dave","r"]])
#----------------------------------------------------------------------
#helper for 3b
def ispowerof2(n)
    if n%2 != 0 ; return false ; end
    if n == 2 ; return true
    elsif n < 2 ; return false
    else ispowerof2(n/2.0) end
end

#3.b.
def rps_tournament_winner(game)
    raise WrongNumberOfPlayersError unless 
 	 game.length == 2 && ispowerof2(game.flatten.length)
    if game.flatten.length == 4 #ending condition
        return rps_game_winner(game)
    else #start recursion
    winnerL = rps_tournament_winner(game[0])
    winnerR = rps_tournament_winner(game[1])
    rps_tournament_winner([winnerL, winnerR])
    end
end
test = [[[["A", "P"],["B","S"]],[["C", "R"],["D", "S"]]],
[[["E", "P"],["F","R"]],[["G", "S"],["H", "S"]]]]
#R beats S, S beats P, P beats R; B,C,E,G->C,G->C should win
p rps_tournament_winner(test)
#----------------------------------------------------------------------
#4.
def combine_anagrams(words)
    hash1 = {}
    sorted = words.sort_by { |x| x.downcase }#sort + downcase each word
    sorted.each do |word| #for each word in the sorted array
        letters = word.split(//).sort #split 1 word into sorted letters
        if hash1[letters].nil? then #check if hash contains letters
	    hash1[letters] = [word] #if not, put word in hash
        else
            hash1[letters].push(word)
            #if key/anagram already exists, add word to it
        end
    end
p hash1.values #pretty-prints the anagrams in arrays
end

combine_anagrams(['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'])
# output: [ ["cars", "racs", "scar"],
#           ["four"],
#           ["for"],
#           ["potatoes"],
#           ["creams", "scream"] ]


