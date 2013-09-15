#----------------------------------------------------------------------
# CHAPTER 3
class Movie
  def initialize(title, year)
    @title = title
    @year = year
  end
#--------------------
  def title
    @title
  end
  def title=(new_title)
    @title = new_title
  end
#instead of the last getters and setters for title, we can use:
  attr_accesor :title
#--------------------
  def year ; @year ; end
  def year=(new_year) ; @year = new_year ; end
#instead of the last getters and setters for year, we can use:
  attr_accesor :year.attr_accessor
#--------------------
  # How to display movie info
  @@include_year = false
  def Movie.include_year=(new_value)
    @@include_year = new_value
  end
  def full_title
    if @@include_year
      "#{self.title} (#{self.year})"
    else
      self.title
    end
  end
end

# Example use of the Movie class

beautiful = Movie.new('Life is Beautiful', '1997')

# What's the movie's name?
puts "I'm seeing #{beautiful.full_title}"

# And with the year
Movie.include_year = true
puts "I'm seeing #{beautiful.full_title}"

# Change the title
beautiful.title = 'La vita e bella'
puts "Ecco, ora si chiama '#{beautiful.title}!'"
#----------------------------------------------------------------------
#3.6. metaprogramming 
#example of using methods 'euro' vs. 'euros'
class Fixnum
  def method_missing(method_id, *args)
    name = method_id.to_s
    if name =~ /^(second|minute|hour)$/ #if method is singular
      self.send(name + 's') #pluralize it and send to self object
    else
      super # pass the buck to superclass
    end
  end
end
#---------------------
#block. 'each' is an instance method on a collection.
movies.each do |m| #for each movie, call it m, convert it's title to a string and print
  puts "#{m.title} was released in #{m.year}"
end
#ruby is lexically scoped: if define variable before block, can use inside block. if define in block, can use inside block but not outside. if define after block, can't use inside block.

#to double elements in a collection:
new_collection = collection.map do |elt|
  2 * elt
end
#or, we can use:
new_collection = collection.map { |elt| 2 * elt }
#no for loops allows duck-typing.
#OR
#--------------------
#regular expressions and looping: this is all technically one line, each period is a method call
words = IO.read("file").#in 'file'
  split(/\W+/). #split by word
  select { |s| s =~ /^[aeiou]/i }.#for every word beginning in a vowel
  map { |s| s.downcase }.#loop over w/ map to downcase it
  uniq.#eliminate duplicates
  sort#sort

#palindrome?
fw = s.downcase.reject{|x| x=~ /\w+/} #downcase and eliminate non-words
bw = fw.reverse
puts fw == bw
#--------------------
#3.7. YIELD
# return every n'th element in an enumerable
module Enumerable
  def every_nth(count)
    index = 0
    self.each do |elt|
      yield elt if index % count == 0
      index += 1
    end
  end
end
list = (1..10).to_a # make an array from a range
list.every_nth(3) { |s| print "#{s}, " }
# => 1, 4, 7, 10,
list.every_nth(2) { |s| print "#{s}, " }
# => 1, 3, 5, 7, 9,


def make_page
  make_header << yield << make_footer
end
def one_page
  make_page { "Hello" } #when this block done executing, returns "hello" to yield so "hello" is appended into the page in make_page. 
#***useful for separating thigs that saty the same from things that change! Like a website layout w/ different content per page.
end
def another_page
  make_page { "World" }
end
end
