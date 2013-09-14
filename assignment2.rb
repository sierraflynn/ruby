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
        # Your code here
    end

    def delicious?
        # Your code here
    end
end
