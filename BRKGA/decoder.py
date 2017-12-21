import numpy as np
import dataset1 as data

def getChromosomeLength(data):
    return data.nNurses

def decode(population, data):
    for ind in population:
        solution, fitness=decoder_assignment(data,ind['chr'])
        ind['solution']=solution
        ind['fitness']=fitness
    return(population)

def decoder_assignment(data, chromosome):
    nurses = list([])
    demand = list(data.demand)
    for index, i in enumerate(chromosome):
        
        if demandMet(demand):
            solution,fitness = generateSolution(nurses)
            return solution, fitness
        startHour = int(i)
        currentHour = startHour
        nurse = Nurse(index)
        if startHour % 2 == 0:
            backwards = False
        else:
            backwards = True
        nurses.append(nurse)
        maxPresence = data.maxPresence
        maxConsec = data.maxConsec
        consec = 0
        while maxPresence > 0 and sum(nurse.hours) < data.maxHours:
            maxPresence -=  1
            if consec < maxConsec:
                nurse.hours[currentHour] = 1
                consec += 1
                demand[currentHour] -= 1
            else: consec = 0
            if currentHour == data.hours - 1:
                currentHour = startHour - 1
                backwards = True
                consec = min(maxConsec,data.hours-startHour)
            elif currentHour == 0:
                currentHour = startHour + 1
                backwards = False
                consec = min(maxConsec,startHour)
            else:
                if backwards: currentHour -= 1
                else: currentHour += 1
    return None, 99999

# Check if demand is mets
def demandMet(demand):
    met = True
    for i in demand:
        if i > 0:
            met = False
    return met

def generateSolution(nurses):
    fitness = len(nurses)
    solution = list([])
    for n in nurses:
        solution.append((n.name,n.hours))
    return solution, fitness

class Nurse:
    def __init__(self,number):
        self.name = number
        self.hours = [0 for i in range(data.hours)]
