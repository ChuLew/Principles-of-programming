module Project where
data RE a            -- regular expressions over an alphabet defined by 'a'
    = Empty          -- empty regular expression
    | Sym a          -- match the given symbol
    | RE a :+: RE a  -- concatenation of two regular expressions
    | RE a :|: RE a  -- choice between two regular expressions
    | Rep (RE a)     -- zero or more repetitions of a regular expression
    | Rep1 (RE a)    -- one or more repetitions of a regular expression
    deriving (Show)
	
matchEmpty :: RE a -> Bool
matchEmpty Empty = True
matchEmpty (Sym a) = False
matchEmpty (a :+: b) = matchEmpty a && matchEmpty b 
matchEmpty (a :|: b) = (matchEmpty a || matchEmpty b) 
matchEmpty (Rep(a)) = True
matchEmpty (Rep1(a)) = matchEmpty a

firstMatches :: RE a -> [a]
firstMatches Empty = [ ] 
firstMatches (Sym a) = [a]
firstMatches (a :+: b) = if matchEmpty(a) 
						 then firstMatches (a :|: b) 
						 else firstMatches a
firstMatches (a :|: b) = firstMatches a ++ firstMatches b
firstMatches (Rep(a)) = firstMatches a
firstMatches (Rep1(a)) = firstMatches a







