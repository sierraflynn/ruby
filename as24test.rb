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
p hash1.values #pretty-prints the array
end

combine_anagrams(['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'])
# output: [ ["cars", "racs", "scar"],
#           ["four"],
#           ["for"],
#           ["potatoes"],
#           ["creams", "scream"] ]

