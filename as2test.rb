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
