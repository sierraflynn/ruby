# Assignment 2
# Sierra Flynn
# Due Thursday 9/17 11:55 pm
# any contributors: Waverly Hinton, Mike Fyk
# github:
# heroku:
#----------------------------------------------------------------------
#0. Lab 2 continued:
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

#----------------------------------------------------------------------
#----------------------------------------------------------------------

#1.a. Create a class Dessert with getters and setters for name and calories. Define instance methods healthy?, which returns true if a dessert has less than 200 calories, and delicious? which returns true for all desserts.
class Dessert
    #initialize class; instance method
    def initialize(name, calories)
	@name = name
	@calories = calories
    end

    #getters
    def name
	@name
    end

    def calories
	@calories
    end

    #setters. Spacing matters!
    def name=(new_name)
	@name = new_name
    end

    def calories=(new_calories)
	@calories = new_calories
    end

    #instance methods
    def healthy?
        if @calories < 200
	    return true
        else return false
        end
    end

    def delicious?
        return true
    end
end

puts "----------Problem 1:"
#test
#note numbers need single quotes too. spacing matters!
favoriteDessert = Dessert.new('chocolate mousse','350')
healthyDessert = Dessert.new('chocolate-covered strawberry','70')
puts "my favorite desert is #{favoriteDessert.name} but it has #{favoriteDessert.calories} calories."
puts "if I split it, it will only be 175."
favoriteDessert.calories=175
if favoriteDessert.healthy?
    puts "now it's healthy!"
end
#----------------------------------------------------------------------
#1.b. Create a class JellyBean that extends Dessert, and add a getter and setter for flavor. Modify delicious? to return false if the flavor is "black licorice" (but delicious? should still return true for all other flavors and for all non-JellyBean desserts).
class JellyBean < Dessert
    #could re-define initialize so it has a flavor to begin with,
    #but instead do getter and setter
    def flavor ; @flavor ; end
    def flavor=(new_flavor) ; @flavor = new_flavor ; end
    def delicious?
        if @flavor == 'black licorice'
            return false
        else return true
        end
    end
end
#test
badJB=JellyBean.new('black licorice jelly bean','10')
badJB.flavor = 'black licorice'
puts "How does the #{badJB.name} taste?"
if !badJB.delicious?
    puts "gross!"
end
goodJB=JellyBean.new('strawberry jelly bean','10')
goodJB.flavor = 'strawberry'
puts "What about the #{goodJB.name}?"
if goodJB.delicious?
    puts "yum!"
end
#----------------------------------------------------------------------
#2. The Class class provides a method, attr_accessor, which uses metaprogramming to create getters and setters for object attributes on the fly. Define a method attr_accessor_with_history that provides the same functionality as attr_accessor but also tracks every value the attribute has ever taken.
class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s       # make sure it's a string
        attr_reader attr_name            # create the attrs getter
        attr_reader attr_name+"_history" # create bar_history getter
	#class_eval allows for metaprogramming (changing code on the fly) or changing a class outside of the class definition. Block passed to class_eval is evaluated in context of the class. Creates methods for Foo class of any name defined in Foo class.
        class_eval %Q{
           		def #{attr_name}=(new_val)
           		   if (!defined? @#{attr_name})
		              @#{attr_name}_history = [nil]
           		   end
           	        @#{attr_name}_history.push(new_val)
          		@#{attr_name} = new_val
                        end
        }
    #passing code as a string to the function class_eval
    end
end

class Foo #Foo is of type Class, so now inherits the method attr_accessor_with_history from it.
    attr_accessor_with_history :bar
end

puts "----Problem 2:"
f = Foo.new     # => #<Foo:0x127e678>
p f
f.bar = 3       # => 3
p f.bar
f.bar = :wowzo  # => :wowzo
p f.bar
f.bar = 'boo!'  # => 'boo!'
p f.bar
f.bar_history   # => [nil, 3, :wowzo, 'boo!']
#'p' pretty prints it
p f.bar_history

class Cookie
   attr_accessor_with_history(:ingredients)
end
m = Cookie.new
m.ingredients = 'eggs'
m.ingredients = 'chocolate chips'
m.ingredients = 'flour'
p m.ingredients_history
#----------------------------------------------------------------------
#multi-line comment:
=begin
[3.a. Currency conversion (ELLS 3.11): Extend the currency-conversion example from lecture so that code such as the following will work:

    5.dollars.in(:euros)
    10.euros.in(:rupees)

You should support the currencies dollars, euros, rupees, yen where the conversions are:

    rupees to dollars, multiply by 0.019,
    yen to dollars, multiply by 0.013,
    euro to dollars, multiply by 1.292.

Both the singular and plural forms of each currency should be acceptable, e.g. 1.dollar.in(:rupees) and 10.rupees.in(:euro) should work.]
=end

#add to Numeric class my 2 methods
class Numeric
 #@@ is a class variable (universal to all instances / global), added to Numeric class
 @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1.0}
 #redefine/override method_missing of Numeric class
 #check if plural; if so, take off the 's'
 def method_missing(method_id)
   singular_currency = method_id.to_s.gsub( /s$/, '')
   if @@currencies.has_key?(singular_currency)
     #convert 
     self * @@currencies[singular_currency]
   else
     super #if method not defined, push up to a higher class
   end
 end
 #define class method 'in' on symbol 'cur'
 #left side of n is always in dollars
 def in(cur)
   cur = cur.to_s.gsub( /s$/, '')
 # :a is a symbol, convert to string 'a'
   if @@currencies.has_key?(cur)
     self/@@currencies[cur]
   end
 end
end

puts "----Problem 3a:"
p 5.euro # 6.46 (in dollars)
p (5.euro).in(:euro) 
# 5 : converts from 5 euros to 6.46 dollars to 5 euros
p 1.dollar.in(:rupees) # => 1/.019 = 52.63
p 10.euros.in(:dollars)
p 10.rupees.in(:euro)
#--------------------------------------------------------------------
#3b) — Palindromes: Adapt your solution from the "palindromes" question so that instead of writing palindrome?("foo") you can write "foo".palindrome? (Hint: this should require fewer than 5 lines of code.)
class String
  def palindrome?
    fw = self.downcase.gsub(/\W+/, '')
    #downcase and eliminate non-words
    return fw == fw.reverse
  end
end
puts "----problem 3b:"
p "A man, a plan, a canal -- Panama".palindrome?
p "not a palindrome".palindrome?
#---------------------------------------------------------------------
=begin
[c) — Palindromes again: Adapt your palindrome solution so that it works on Enumerables. That is:
[1,2,3,2,1].palindrome? # => true

It's not necessary for the collection's elements to be palindromes themselves--only that the top-level collection be a palindrome. (Hint: this should require fewer than 5 lines of code.) Although hashes are considered Enumerables, your solution does not need to work with hashes, though it should not error.]
=end

module Enumerable #add method palindrome? to already existing class
  def palindrome?
    return self == self.reverse
  end
end
puts "----Problem 3c: "
p [1,2,2,1].palindrome?
p [1,2,3,2,1].palindrome?
p [1,2,3].palindrome?
p [[1,2],[3,4],[1,2]].palindrome?
p [[1,2],[3,4],[2,1]].palindrome?
p [["a"] => 1, ["b"] => 1, ["a"] => 2].palindrome? #true
#---------------------------------------------------------------------
#4.
class CartesianProduct
    include Enumerable #include methods from mixin Enumerable
    def initialize(a, b)
        @a = a
        @b = b
        @cp = []
        @a.each do |aa|
          @b.each do |bb|
          @cp.push([aa, bb])
          end
       end
    end
    def each
       @cp.each do |item|
          yield item #apply block called below to each item as |elt|
       end
    end
end
puts "----Problem 4: "
c = CartesianProduct.new([:a,:b,:c], [1,2])
c.each { |elt| puts elt.inspect }
c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
