# Assignment 2
# Sierra Flynn
# Due Thursday 9/17 11:55 pm
# any contributors:
# github:
# heroku:
#----------------------------------------------------------------------
#1.a. Create a class Dessert with getters and setters for name and calories. Define instance methods healthy?, which returns true if a dessert has less than 200 calories, and delicious? which returns true for all desserts.
class Dessert
    #initialize class
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
    def initialize(name, calories, flavor)
        @name = name
	@calories = calories
	@flavor = flavor
    end

    def delicious?
        if @flavor == 'black licorice'
            return false
        else return true
        end
    end
end
#test
badJB=JellyBean.new('black licorice jelly bean','10','black licorice')
puts "How does the #{badJB.name} taste?"
if !badJB.delicious?
    puts "gross!"
end
goodJB=JellyBean.new('strawberry jelly bean','10','strawberry')
puts "What about the #{goodJB.name}?"
if goodJB.delicious?
    puts "yum!"
end
#----------------------------------------------------------------------
#2. The Class class provides a method, attr_accessor, which uses metaprogramming to create getters and setters for object attributes on the fly. Define a method attr_accessor_with_history that provides the same functionality as attr_accessor but also tracks every value the attribute has ever taken. The following example shows the basic behavior of the new accessor:
class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s       # make sure it's a string
        attr_reader attr_name            # create the attrs getter
        attr_reader attr_name+"_history" # create bar_history getter
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

class Foo
    attr_accessor_with_history :bar
end

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

class Numeric
 #@@ is a class variable, added to Numeric class
 @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1.0}
 #check if plural
 def method_missing(method_id)
   singular_currency = method_id.to_s.gsub( /s$/, '')
   #if self =~ /\d+\.dollar\s?/
   if @@currencies.has_key?(singular_currency)
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

p 5.euro # 6.46 (in dollars)
p (5.euro).in(:euro) 
# 5 : converts from 5 euros to 6.46 dollars to 5 euros
p 1.dollar.in(:rupees) # => 1/.019 = 52.63
p 10.euros.in(:dollars)
p 10.rupees.in(:euro)
#--------------------------------------------------------------------
#3b) — Palindromes: Adapt your solution from the "palindromes" question so that instead of writing palindrome?("foo") you can write "foo".palindrome? (Hint: this should require fewer than 5 lines of code.)
#module String
class String
  def palindrome?
    fw = self.downcase.reject{|x| x=~ /\w+/} 
    #downcase and eliminate non-words
    if fw == fw.reverse
       return true
    else 
       return false
    end
  end
end
#ispal = "A man, a plan, a canal -- Panama".palindrome?
#---------------------------------------------------------------------
=begin
[c) — Palindromes again: Adapt your palindrome solution so that it works on Enumerables. That is:
[1,2,3,2,1].palindrome? # => true

It's not necessary for the collection's elements to be palindromes themselves--only that the top-level collection be a palindrome. (Hint: this should require fewer than 5 lines of code.) Although hashes are considered Enumerables, your solution does not need to work with hashes, though it should not error.]
=end

module Enumerable
  def palindrome?
    if self == self.reverse
       p true
       else p false
    end
  end
end
[1,2,2,1].palindrome?
[1,2,3,2,1].palindrome?
[1,2,3].palindrome?
#---------------------------------------------------------------------
#4.
class CartesianProduct
    include Enumerable
    def initialize(a, b)
        @a = a
        @b = b
        ret = []
        @a.each do |aa|
          @b.each do |bb|
          ret = ret + [aa, bb]
          end
       end
       return ret
    end
end
c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }
