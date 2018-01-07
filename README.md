AMMM course project
Authors: Kymry Burwell and Jerome Pasvantis

GRASP Instructions:
Step 1: Choose the desired data set by commenting all others in the data.py file.
Step 2: Set alpha. In main.py search for comment "# Set alpha here". Set alpha on this line.
Step 3: Set max iterations. In main.py search for comment "# Set iterations here". Set iterations on this line.
Step 4: Run main.py
Step 5: View results. Each number printed is the total number of working nurses. The final array of lists is the solution. Example below.
[0, [10, 11, 12, 14, 15, 16, 18, 19, 21]]  - Nurse number 0 works hours 10, 11, etc.
[3, [13, 14, 16, 17, 18]] - Nurse number 3 works hours 13, 14, etc.

BRKGA Instructions:
Step 1: Choose the desired data set by commenting all others in the data.py file.
Step 2: Choose configuration parameters in the configuration.py file. We recommend setting the numIndividuals to at least the number of nurses.
Step 3: Run main.py
Step 4: view results. Each number printed is the total number of working nurses. If no solution is found, 99999 is returned. The final list is the solution. Example is below.
[(0, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0]) - Nurse 0 works hours 12, 13, etc.
(1, [0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]) - Nurse 1 works hours 6, 7, etc.

ILP Instructions:
Step 1: Choose the desired data set by commenting all others in the AMMMdata.dat file.
Step 2: Run AMMMProject.mod
