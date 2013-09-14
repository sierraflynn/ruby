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
class Class #*****
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s       # make sure it's a string
        attr_reader attr_name            # create the attribute's getter
        attr_reader attr_name+"_history" # create bar_history getter
        class_eval "your code here, use %Q for multiline strings"
    end
end

class Foo
    def initialize
        @bar=nil
        @bar_history = [@bar]
    end
    def bar
        @bar
    end
    def bar=(new_bar)
        @bar=new_bar
        #append to history array
        @bar_history=@bar_history << new_bar
        return @bar
    end
    def bar_history
        @bar_history
    end
    #attr_accessor_with_history :bar ***********
end

f = Foo.new     # => #<Foo:0x127e678>
puts f
f.bar = 3       # => 3
puts f.bar
f.bar = :wowzo  # => :wowzo
puts f.bar
f.bar = 'boo!'  # => 'boo!'
puts f.bar
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

Both the singular and plural forms of each currency should be acceptable, e.g. 1.dollar.in(:rupees) and10.rupees.in(:euro) should work.]
=end

class Numeric
 @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
 def method_missing(method_id)
   singular_currency = method_id.to_s.gsub( /s$/, '')
   if @@currencies.has_key?(singular_currency)
     self * @@currencies[singular_currency]
   else
     super
   end
 end
 def euro
    self*@@currencies['euro']
 end
 def euros
    self.euro
 end
end
