# Bigram Analysis
import operator

# Read from bigram result file
bigramCount = {}
with open( "temp.txt" ) as f:
    for line in f:
    	bigramCount[ line.split()[0] + " " + line.split()[1] ] = int( line.split()[2] )
totalNum = sum( bigramCount.values() ) 
print "(a) the total number of bigrams is:", totalNum

# Frequceny
freq = sorted(bigramCount.items(), key=operator.itemgetter(1), reverse=True)
# break the tie??
print "(b) the most common bigram is:", freq[0][0]

# make at least 10% of the total number of bigrams
oneTen = totalNum/10
count = 0
index = 0
print "(c) the number of bigrams required to add up to 10% of all bigrams"

while ( count<oneTen ):
	print freq[index][0] + ": "+ str(freq[index][1])
	count = count + freq[index][1] 
	index = index + 1

