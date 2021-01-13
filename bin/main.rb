#!/usr/bin/env ruby
$prime = [];

def initArray(limit)

  arr = [];
  arr.fill(false, 0..limit);
  return arr;
end

# This functions finds all
# primes smaller than limit
# using simple sieve of eratosthenes.
# It stores found
# primes in vector prime[]
def simpleSieve(limit)

    i = 2
	mark = initArray(limit);
	until i*i >= limit do

		if mark[i] == false
			# If not marked yet, then its a prime
			$prime.push(i);

			j = i;
			until j >= limit do

			    mark[j] = true
			    j += i

			end
		end
		i=1+i

	end

end

# Finds all prime numbers in given range using segmented sieve
def primesInRange(low, high)

	# Compute all primes smaller or equal to
	# square root of high using simple sieve

	limit = (Math.sqrt(high)) + 1;
	simpleSieve(limit);

	# Count of elements in given range
	n = high - low + 1;

	# Declaring boolean only for [low, high]
  	mark = initArray((n+1));

	# Use the found primes by
	# simpleSieve() to find
	# primes in given range
	$prime.each_with_index do |val, i|
		# Find the minimum number in [low..high] that is
		# a multiple of prime[i] (divisible by prime[i])
		loLim = low / val * val
		if loLim < low
			loLim += val;
		end
		if loLim==val
			loLim += val;
		end

	# Mark multiples of prime[i] in [low..high]:
	#	We are marking j - low for j, i.e. each number
	#	in range [low, high] is	mapped to [0, high - low]
	#	so if range is [50, 100] marking 50 corresponds
	#	to marking 0, marking 51 corresponds to 1 and
	#	so on.
  #  Also if the current j is prime don't mark
	#	it as true.In this way we need to allocate space only
	#	for range
	j = loLim;
		until j > high do
		    if j != val
		        mark[j - low] = true;
		    end
		    j += val
		end
	end

	# Numbers which are not marked
	# in range, are prime
	o = []
	for i in low..high do
       if mark[i - low]==false
          o.push(i);
        end
    end
    puts("[OUTPUT] %s" % o.join(","));
end

# Driver program to test above functions */
def main
  low = 10;
  high = 20;
	puts("[INPUT] low: %d\thigh: %d" % [low, high]);
    primesInRange(low, high);
end
main
