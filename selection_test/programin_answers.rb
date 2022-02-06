require 'prime'

target_primes = Prime.first 1000
n = (1..1000).to_a
k = (1..10000000).to_a

def f_function k,n
	n.map{|n_i| n_i**2 + k**2}
end

def max_factor value, primes
	primes[1..value].select{|i| value % i == 0 }.max
end

def p_function k_i, n, primes
	target_serie = f_function(k_i,n).map{|f_i| max_factor(f_i, primes)}
	repited_elements = n.select{|i| target_serie[i] == target_serie[i + 1]}
	repited_elements.map{|j| target_serie[j]}.compact.max
end

def common_factor k
end


