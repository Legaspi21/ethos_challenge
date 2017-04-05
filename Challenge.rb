# A "cool number" is determined by the following process. Start with the initial integer.
# Replace this number with the sum of the square of its digits. Repeat this process
# until the result is 1 (where the sequence remains 1) or it loops endlessly.

# For instance, let's take 23 as an example:<br />
# 1. 2^2 + 3^2 = 13<br />
# 2. 1^2 + 3^2 = 10<br />
# 3. 1^2 + 0^2 = 1<br />
# Therefore 23 is a "cool number";

# HINT: All "uncool numbers" will yield "4" at some point in their sequence then repeat in a loop forever.

# Your task: determine the sum of all "cool numbers" starting with 1 and going up to and including 1,000,000.

# When you're done, make a POST request to the following APIs:
# /code1, /code2, /code3, ..., /code100
# with the header
# "X-COOL-SUM" equal to your answer. Most of the routes will return 404. But some will return a letter when provided with the right "cool sum". The code is the letters put together in the order of the requests.

require 'net/http'
require 'uri'

class CoolNumbers
  @@count = 0 # <--- Used a class variable storing the count of cool numbers to verify the correct number of items in the cool numbers array
  def self.cool_number_checker(int)
    result = int.to_s.chars.map(&:to_i).reduce(0) {|sum,x| sum += x**2}
    if result == 4 
      return -1
    elsif result > 1
      cool_number_checker(result)
    elsif result == 1
      @@count += 1
      return 1
    end
  end 

  def self.count
    @@count
  end
end

cool_numbers = []

[*1..1000000].each do |num|
  CoolNumbers.cool_number_checker(num) > 0 ? cool_numbers << num : nil
end

# p CoolNumbers.count

COOL_SUM = cool_numbers.reduce(:+).to_s

response_array = []

1.upto(100) do |i|

  uri = URI.parse("http://dev.getethos.com/code#{i}")

  header = {'X-COOL-SUM': COOL_SUM}

  http = Net::HTTP.new(uri.host, uri.port)

  request = Net::HTTP::Post.new(uri.request_uri, header)

  response = http.request(request)

  response_array << response.body if response.body != "Not Found"

end

p response_array.join('')

# FINAL RESULT

# => "ilovejavascript"

# Process

# My first step was to inspect the page and view the source to find any clues 
# Once I found the directions were hidden by a {display: none} css property I was able to reveal them using javascript by changing the display to block in the devtools console
# The next step was writing the algorithm. I figured I was going to be performing the same operation on every number and its result so for that I felt that recursion made sense
# My initial thought was that I needed to count the total cool numbers which is why I implemented the class variable to keep count
# Upon getting some 400 status codes I reread the prompt and had an aha moment. 
# Adjustments were: Arbitrary return values to trigger the ternary to append only the numbers we care about to a new cool_numbers array
# Then simply reduce to sum the array into our final value we need to pass to the header
# The API calls couldn't be simpler, just a string interpolation of the numbers 1-100 in the uri each time and populate a response array with our 200 status code respose bodies.
# Voila! "ilovejavascript" .. written in Ruby co-starring JavaScript 