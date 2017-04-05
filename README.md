# ethos_challenge

 A "cool number" is determined by the following process. Start with the initial integer.
 Replace this number with the sum of the square of its digits. Repeat this process
 until the result is 1 (where the sequence remains 1) or it loops endlessly.

 For instance, let's take 23 as an example:
 1. 2^2 + 3^2 = 13
 2. 1^2 + 3^2 = 10
 3. 1^2 + 0^2 = 1
 Therefore 23 is a "cool number";

 HINT: All "uncool numbers" will yield "4" at some point in their sequence then repeat in a loop forever.

 Your task: determine the sum of all "cool numbers" starting with 1 and going up to and including 1,000,000.

 When you're done, make a POST request to the following APIs:
 /code1, /code2, /code3, ..., /code100
 with the header
 "X-COOL-SUM" equal to your answer. Most of the routes will return 404. But some will return a letter when provided with the right "cool sum". The code is the letters put together in the order of the requests.


Process

> My first step was to inspect the page and view the source to find any clues .
> Once I found the directions were hidden by a {display: none} css property I was able to reveal them using javascript by changing the display to block in the devtools console.
> The next step was writing the algorithm. I figured I was going to be performing the same operation on every number and its result so for that I felt that recursion made sense.
> My initial thought was that I needed to count the total cool numbers which is why I implemented the class variable to keep count.
> Upon getting some 400 status codes I reread the prompt and had an aha moment. 
> Adjustments were: Arbitrary return values to trigger the ternary to append only the numbers we care about to a new cool_numbers array.
> Then simply reduce to sum the array into our final value we need to pass to the header.
> The API calls couldn't be simpler, just a string interpolation of the numbers 1-100 in the uri each time and populate a response array with our 200 status code respose bodies.
> Voila! "ilovejavascript" .. written in Ruby co-starring JavaScript.
