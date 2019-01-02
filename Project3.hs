module Project where
	data Tree a = Leaf a | Fork (Tree a) (Tree a) deriving (Show, Eq, Ord)
	data BST a = Tip | Bin (BST a) a (BST a) deriving (Show, Eq, Ord)
	
	cart :: [a] -> [b] -> [(a, b)]
	cart (x:xs) ys = map (\y -> (x, y)) ys ++ cart xs ys
	cart _ _  = []
	

	stddev :: [Double]-> Double
	stddev xs = sqrt(((sum (map (\x -> x^2)(map (subtract u) xs)))/fromIntegral(length xs)))
			where u = sum xs / fromIntegral(length xs)	
			
	height :: Tree a -> Int
	height (Leaf _) = 0 
	height (Fork left right) = 1 + max (height left)(height right)
	
	minLeaf:: Ord a => Tree a -> a
	minLeaf (Leaf a) = a
	minLeaf (Fork left right) = min (minLeaf left) (minLeaf right)
	
	inorder :: Tree a -> [a]
	inorder (Leaf a) = [a]
	inorder (Fork left right) = inorder left ++ inorder right
	
	contains:: Ord a => a -> BST a -> Bool
	contains value branch = case branch of
			Tip -> False 
			Bin left traverse right | traverse == value -> True
			Bin left traverse right -> 
				if value <= traverse
				then (contains value left)
				else (contains value right)
				
	insert :: Ord a => a -> BST a -> BST a
	insert value t = case t of 
		Tip -> Bin Tip value Tip 
		Bin left traverse right -> 
			if value <= traverse
			then Bin (insert value left) traverse right
			else Bin left traverse (insert value right) 

	delete :: Ord a => a -> BST a -> BST a
	delete value t = case t of 
		Tip -> Tip 
		Bin l v r | value < v-> Bin (delete value l) v r 
		Bin l v r | value > v -> Bin l v (delete value r) 
		Bin Tip v Tip | v == value -> Tip
		Bin l v Tip | v == value -> l
		Bin Tip v r | v == value -> r

		
	
	 
	