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

class CoolNumbers
  @@count = 0 
  def self.cool_number_checker(int)
    result = int.to_s.chars.map(&:to_i).reduce(0) {|sum,x| sum += x**2}
    if result == 4 
      return
    elsif result > 1
      cool_number_checker(result)
    elsif result == 1
      @@count += 1
      return
    end
  end 

  def self.count
    @@count
  end
end

[*1..1000000].each do |num|
  CoolNumbers.cool_number_checker(num)
end

p CoolNumbers.count

