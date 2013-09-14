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
palindrome?("Abracadabra")                       # => false (nil is also

#----------------------------------------------------------------------
#Part 2.b.
def count_words(string)
    #words = (string.downcase.scan(/\b+(\w+)\b+/))
    #match downcased string with words between word boundaries
    #hash1 = Hash.new { |hash, key| hash[key] = words.each }
    hash1 = {} #{ words.each => 0 }
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
    #raise error if plyer uses bad strategy
    strategy = /^(r|R|s|S|p|P)$/
    raise NoSuchStrategyError unless 
	game[0][1] =~ strategy && game[1][1] =~ strategy
    #R beats S, S beats P, P beats R
    if game[0][1].downcase == "r"
         if game[1][1].downcase == "r" || game[1][1].downcase == "s"
		winner = game[0][0]
		winningplay = game[0][1]
	  else 
		winner = game[1][0] 
		winningplay = game[1][1]
          end
    else if game[0][1].downcase == "s"
         if game[1][1].downcase == "s" || game[1][1].downcase == "p"
		winner = game[0][0]
		winningplay = game[0][1]
	  else 
		winner = game[1][0] 
		winningplay = game[1][1]
	  end
    else #if game[0][1] == "P" | "p"
         if game[1][1].downcase == "p" || game[1][1].downcase == "r"
		winner = game[0][0]
		winningplay = game[0][1]
	  else 
		winner = game[1][0] 
		winningplay = game[1][1]
	  end
    end
return [winner, winningplay]
end
end
p rps_game_winner([["Armando","p"],["Dave","S"]])
p rps_game_winner([["Armando","s"],["Dave","S"]])
p rps_game_winner([["Armando","s"],["Dave","r"]])
#----------------------------------------------------------------------
#3.b. not quite working but I believe it is close!
def rps_tournament_winner(game)
#debugging purposes
p game
    if game.flatten.length <= 4
	#ending condition
        return rps_game_winner(game)
    else 
	#start recursion
    winnerL = rps_tournament_winner(game[0])
    winnerR = rps_tournament_winner(game[1])
    rps_tournament_winner([winnerL, winnerR])
    end
end
#test = [[["Aaa", "P"],["Bbb","S"]],[["Ccc", "R"],["Ddd","S"]]]
#R beats S, S beats P, P beats R; C should win
#puts rps_tournament_winner(test)
#----------------------------------------------------------------------
#4.
def combine_anagrams(words)
    hash1 = {}
    sorted = words.sort_by { |x| x.downcase }#sort + downcase each word
    sorted.each do |word| #for each word in the sorted array
        letters = word.split(//).sort #split 1 word into sorted letters
        if hash1[letters].nil? then #check if hash contains letters
	    hash1[letters] = word #if not, put word in hash
        else
            hash1[letters] += " " + word 
            #if key/anagram already exists, add word to it
        end
    end
#now we have a hash where each key holds a list of anagrams.
#Now we want to split it into a multi-dimensional array:
    arr = Array.new
    i = 0
    hash1.keys.each do |list| #for each list of anagrams
	arr[i] = hash1[list].split(" ") #split up words by spaces
	i = i+1
    end
p arr #pretty-prints the array
end

combine_anagrams(['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'])
# output: [ ["cars", "racs", "scar"],
#           ["four"],
#           ["for"],
#           ["potatoes"],
#           ["creams", "scream"] ]

