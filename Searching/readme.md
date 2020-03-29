In this playground I compare the following search methods:
1. Recursive Binary Search.
2. Iterative Binary Search.
3. Linear Search (implemented by me).
4. Linear Search (implemented by [firstIndex(of:)](https://developer.apple.com/documentation/swift/array/2994720-firstindex))


## Results

Search methods were tested on a 2019 Macbook Pro with 2.2 GHz 6-Core Intel Core i7 and 16GB or RAM.

The array used for testing had 1 million Integers ranging from `0` to `Int.max - 1`. 

With the cost of sorting included Binary Search of course performs the worst. 
  Avg Times:
  - Recursive Binary Search `15.604` seconds.
  - Iterative Binary Search `18.038` seconds.
  - Linear Search (implemented by me) `0.732` seconds.
  - Linear Search (implemented by firstIndex(of:) `0.121`.
  
With the cost of sorting removed we get drastically different results.
  Avg Times:
  - Recursive Binary Search `0.001` seconds longest run `0.001198` seconds.
  - Iterative Binary Search `0.000` seconds longest run `0.000469` seconds.
  - Linear Search (implemented by me) `0.627` seconds.
  - Linear Search (implemented by firstIndex(of:) `0.097`.
