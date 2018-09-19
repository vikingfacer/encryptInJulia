




function insertion_sort!(A::Array{T}) where T <: Number
	for i in 1:length(A) -1
		value = A[i+1]
		j = i 
		while j > 0 && A[j] > value
			A[j + 1] = A[j]
			j -= 1
		end
		A[j + 1] = value
	end
	return A

end

function bubble_sort!(A::Array{T}) where T <: Number
	for _ in 2:length(A), j in 1:length(A) -1
		if A[j] > A[j+1]
			A[j], A[j+1] = A[j+1], A[j]
		end
	end
	return A
end

function selection_sort!(A::Array{T}) where T <:Number
	
	for i in 1:length(A)
		min = i
		for j in i:length(A)
			if A[min] > A[j]
				min = j
			end
		end
		if min != i
		    A[min], A[i] = A[i], A[min]
		end
	end

	return A
end

function merge_sort(A::Array{T}, p, r) where T <:Number
	if p < r 
		q = (p + r)/2 
		merge_sort(A, p, q)
		merge_sort(A, q+1, r)
		Mymerge(A, p, q, r)
	end
end

function Mymerge(A::Array{64}, p, q, r) 
	n1 = q - p + 1
	n2 = r - q
	L = []
	R = []
	for i in 1:n1 
		push!(L, p+i-1)
	end
	for i in 1:n1
		push!(R, q + i)
	end
	i = 1
	j = 1
	for k in p:r 
		if L[i] <= R[j]
			A[k] = L[i]
			i = i + 1
		else
			A[k] = R[j]
			j = j + 1
		end
	end 

	end


x = randn(5)
@show x insertion_sort!(x)

x = randn(8)
@show x bubble_sort!(x)

x = randn(8)
@show x selection_sort!(x)