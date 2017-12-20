X = 10
minHours = 7
maxHours = 12
maxConsec = 7
maxPresence = 14

#TODO: minHours

def compute(candidate):
	cost = 0
	
	nurse = candidate[0]
	hour = candidate[1]

	# Make hours that already have enough nurses more expensive
	if hour.noNurses >= hour.demand:
		cost += X

	# But if nurse needs to work more, let her work
	if nurse.working < minHours and nurse.used:
		cost -= X

	# Make it more expensive to use a "new" nurse
	if not nurse.used:
		cost += X

	candidate[2] = cost

def updateCandidates(candidateList, candidate):
	# Add hour to nurse and add nurse to hour
	candidate[0].addHour(candidate[1].number)
	candidate[1].addNurse()
	#print "x {0}".format(len(candidateList))	# Remove candidate from candidateList
	candidateList.remove(candidate)

	# Update Greedy Cost
	for c in candidateList:
		compute(c)	

	#print "y {0}".format(len(candidateList))


	