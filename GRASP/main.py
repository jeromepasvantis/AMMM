import greedy
import sys
from random import randint

class Nurse:
	"""docstring for ClassName"""
	def __init__(self, number):
		self.number = number
		self.hours = []
		self.working = 0
		self.used = False
	def __repr__(self):
		return "Nurse {0}".format(self.number)

	def addHour(self, hour):
		self.hours.append(hour)
		self.working = len(self.hours)
		self.used = True

class Hour:
	def __init__(self, number, demand):
		self.number = number
		self.demand = demand
		self.noNurses = 0

	def addNurse(self):
		self.noNurses += 1

	def __repr__(self):
		return "Hour {0}".format(self.number)

nursesList = []
hoursList = []
sol = list([])
"""
minHours = 5
maxHours = 9
maxConsec = 5
maxPresence = 14
"""
minHours = 7
maxHours = 12
maxConsec = 7
maxPresence = 14
def construct(alpha=0.2):
	#initialize Candidate Set
	C = []
	
	for hour in hoursList:
		for nurse in nursesList:
			candidate = [nurse, hour, 0]
			C.append(candidate)

	tempRemoved = list([])

	while len(C) > 0:
		
		C.sort(key= lambda x:x[2])

		smin = C[0][2]
		smax = C[-1][2]
		
		# Build RCL
		threshold = smin + alpha * (smax - smin)

		RCL=list([])
		i=0
		while len(RCL) < len(C):
			if C[i][2] > threshold: break
			RCL.append(C[i])
			i += 1

		# Pick random tuple out of RCL
		if len(RCL) < 1: break
		pick = randint(0,len(RCL)-1)
		sol.append(RCL[pick])

		#Add temporarily removed candidates
		C.extend(tempRemoved)
		tempRemoved[:] = []

		# Update Candidate Set
		greedy.updateCandidates(C, RCL[pick])

		# Check if feasible solution already found - when demand is fulfiled and minHours
		Feasible = True
		for h in hoursList:
			if h.noNurses < h.demand: Feasible = False
		
		for n in nursesList:
			if n.used: 
				if n.working < minHours: Feasible = False
				
		if Feasible: 
			#Calculate Cost of Solution!
			cost = 0
			for nurse in nursesList:
				if nurse.working > 0: 
					cost += 1
			
			return cost

		# Remove unfeasible solutions
		newC = list([])
		for c in C:
			n = c[0]
			h = c[1]
			# Calculate the presence of the nurse including the candidate
			minh = h.number
			maxh = h.number
			for hour in n.hours:
				if hour > maxh: maxh = hour
				if hour < minh: minh = hour
			presence = maxh - minh
			# Calculate the maximum consecutive hours
			temphours = list(n.hours)
			temphours.append(h.number)
			temphours.sort()
			consec = True
			for index, hour in enumerate(temphours):
				count = 1
				for index2, hour2 in enumerate(temphours):
					if index2 <= index: continue
					if hour == hour2 - (index2-index):
						count += 1
					else: break
				if count > maxConsec:
					consec = False
					break

			# Remove candidates temporarily for consecBreak
			tempNotFeasible = True
			if not n.used:
				tempNotFeasible = False 
			for index, hour in enumerate(n.hours):
				if h.number in range(hour-2, hour+3):
					tempNotFeasible = False
					break

			if tempNotFeasible:
				tempRemoved.append(c)

			if (n.working+1 <= maxHours) and (presence <= maxPresence) and consec and (not tempNotFeasible):
				newC.append(c)

		C = newC
	return None		
	

def local(solNurses, solHours, cost):
	
	for n in solNurses:
		
		hToCheck = list(n.hours)
		Feasible = True

		for h in solHours:
			if h[0] in hToCheck:
				if h[1] - 1 < h[2]: Feasible = False

		if Feasible:
			newsolNurses = list(solNurses)
			newsolNurses.remove(n)
			newsolHours = list(solHours)
			for h in newsolHours:
				if h[0] in hToCheck:
					h[1] -= 1
			print "{0} - {1}".format(len(newsolNurses), n)
			local(newsolNurses, newsolHours, cost-1) 

	return None

def main(argv=None):
	nNurses = 30
	nHours = 24
	demand = [2,2,1,1,1,2,2,8,9,9,5,7,5,8,8,7,10,10,5,3,4,3,3,3]
	#[2,2,1,1,1,2,2,3,4,3,3,7,5,8,8,7,0,0,5,3,4,3,3,3]

	#Create Nurses and Hours
	for n in range(nNurses):
		n = Nurse(n)
		nursesList.append(n)

	for n in range(nHours):
		h = Hour(n, demand[n])
		hoursList.append(h)

	cost = construct(0.3)

	print "Cost (Greedy): {0} ".format(cost)

	#for s in sol:
	#	print s

	#Create solNursesList and solHoursList for local search
	solNurses = list([])
	for n in nursesList:
		if n.used:
			solNurses.append(n)

	solHours = list([])
	for h in hoursList:
		solHours.append([h.number, h.noNurses, h.demand])
 	if sol: 
		local(solNurses, solHours, cost)




if __name__ == "__main__":
    sys.exit(main())