install.packages("ggplot2")
library(ggplot2)

# grasp parameters
alpha <- .4
iteration <- 20

#BRKGA parameters
mutant <- .2
elite <- .2
inheritance <- .6
numIndividual <- c(100,300) # a = 5. n = size of chromsomoe
numGeneration <- 100

#size of dataset
nNurses <- c(20,60,120)
minHours <- c(5,4,4)
maxHours <- c(9,10,10)
maxConsec <- c(3,4,5)
maxPresence <- c(14,12,12)

#------ OPL vs Grasp vs Brkga ------#
size <- c(20,60,120,220)

olpTime <- c(1.03,74.81,749.86,755.69)
olpSol <- c(11,26,69,103)
 
graspTime <- c(5.5,33.1,184.0,489)
graspSol <- c(14,29,75,114)

brkgaTime <- c(1.5,2.2,5.4,13.3)
brkgaSol <- c(16,29,78,119)

# solution chart
compareSolDF <- data.frame(size,olpSol,graspSol,brkgaSol)
ggplot(compareSolDF, aes(size)) + # basic graphical object
  geom_line(aes(y=olpSol, colour="ILP")) +  # first layer
  geom_line(aes(y=graspSol, colour="GRASP")) + # second layer
  geom_line(aes(y=brkgaSol, colour="BRKGA")) + # second layer
  ylab("Solution") + xlab("Problem Size (# nurses)") + 
  labs(title="BRKGA vs GRASP vs ILP")+
  scale_colour_manual("", 
                    breaks = c("ILP", "GRASP", "BRKGA"),
                    values = c("red", "green", "blue"))+
  theme(plot.title = element_text(hjust = 0.5))+geom_point(aes(y=olpSol))+
  geom_point(aes(y=graspSol))+geom_point(aes(y=brkgaSol))


#time chart
compareTimeDF <- data.frame(size,olpTime,graspTime,brkgaTime)
ggplot(compareTimeDF, aes(size)) + # basic graphical object
  geom_line(aes(y=olpTime, colour="ILP")) +  # first layer
  geom_line(aes(y=graspTime, colour="GRASP")) + # second layer
  geom_line(aes(y=brkgaTime, colour="BRKGA")) + # second layer
  ylab("Execution Time (seconds)") + xlab("Problem Size (# nurses)") + 
  labs(title="BRKGA vs GRASP vs ILP")+
  scale_colour_manual("", 
                      breaks = c("ILP", "GRASP", "BRKGA"),
                      values = c("red", "green", "blue"))+
  theme(plot.title = element_text(hjust = 0.5)) +geom_point(aes(y=olpTime))+
  geom_point(aes(y=graspTime))+geom_point(aes(y=brkgaTime))
  

#------ Grasp vs Brkga ------#
#solB <- c(1134, 1098, 1076, 1050, 1029, 1029, 1003, 990, 990, 974, 969, 969, 961, 956, 951, 951, 950, 949, 949, 929, 916, 916, 916, 916, 916, 913, 913, 912, 907, 907, 904, 904, 904, 904, 898, 897, 897, 897, 896, 888, 888, 888, 887, 883, 883, 883, 883, 883, 883, 883, 883, 883, 883, 883, 883, 883, 880, 880, 880, 880, 880, 878, 878, 875, 875, 875, 875, 875, 872, 872, 871, 871, 871, 868, 868, 864, 863, 863, 863, 863, 863, 863, 862, 862, 862, 860, 859, 859, 859, 859, 858, 857, 856, 856, 856, 855, 855, 855, 855, 855, 855, 854, 854, 852, 852, 852, 852, 852, 852, 852, 852, 852, 851, 850, 850, 850, 848, 848, 848, 848, 848, 848, 848, 848, 846, 846, 846, 843, 843, 843, 843, 843, 843, 843, 843, 842, 842, 839, 839, 839, 839, 839, 837, 837, 837, 837, 837, 837, 836, 836, 836, 836, 836, 834, 834, 834, 834, 834, 834, 834, 833, 833, 833, 833, 833, 833, 833, 833, 831, 831, 831, 831, 831, 831, 830, 830, 830, 830, 830, 830, 830, 828, 828, 826, 826, 826, 826, 826, 826, 826, 826, 826, 826, 826, 825, 824, 822, 822, 822, 822, 822, 822, 822, 822, 822, 822, 821, 821, 820, 820, 820, 820, 820, 820, 820, 820, 820, 820, 820, 820, 820, 819, 819, 819, 819, 819, 819, 819, 819, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 818, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 817, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 816, 815, 815, 815, 815, 815, 814, 814, 814, 814, 814, 814, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 813, 809, 809, 809, 809, 809, 809, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 808, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 807, 806, 806, 806, 806, 806, 806, 806, 806, 806, 806, 806, 806, 806, 806, 806, 806, 805, 805, 805, 805, 805, 805, 805, 805, 805, 805, 801, 801, 801, 801, 801, 801, 801, 801, 801,801)
#rtimeB <- seq(from = 0, to = 899, by = 1.8)

solG <- c(225,225,225,225,225,225,225,225,225,225,225,223,223,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218,218)
rtimeG <- seq(from = 0, to = 6780, by = 133)
iterationsG <- 1:51
iterationsB <- 1:191

solB <- c(278,278,274,270,270,270,268,268,263,263,261,259,252,252,252,252,252,250,247,247,241,241,241,241,241,241,241,241,241,241,237,237,236,231,231,231,231,231,231,231,231,231,230,230,230,230,230,230,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,226,226,226,226,226,226,226,226,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222,222)
rtimeB <- seq(from = 0, to = 667, by = 3.5)

#iterations df for grasp
iterationsDF <- data.frame(solG,iterationsG)
ggplot(iterationsDF, aes(iterationsG)) +
  geom_line(aes(y=solG)) +
  ylab("solution")+xlab("iteration")+
  labs(title="GRASP iterations")+ 
  theme(plot.title = element_text(hjust = 0.5))

#iterations df for BRKGA
iterationsDF <- data.frame(solB,iterationsB)
ggplot(iterationsDF, aes(iterationsB)) +
  geom_line(aes(y=solB)) +
  ylab("solution")+xlab("iteration")+
  labs(title="BRKGA iterations")+ 
  theme(plot.title = element_text(hjust = 0.5))

#running time df for BRKGA
rtimeDF <- data.frame(solG,rtimeG)
ggplot(rtimeDF, aes(rtimeG)) +
  geom_line(aes(y=solG)) +
  ylab("solution")+xlab("running-time (seconds)")+
  labs(title="GRASP running-time")+ 
  theme(plot.title = element_text(hjust = 0.5))

#running time df for BRKGA
rtimeDF <- data.frame(solB,rtimeB)
ggplot(rtimeDF, aes(rtimeB)) +
  geom_line(aes(y=solB)) +
  ylab("solution")+xlab("running-time (seconds)")+
  labs(title="BRKGA running-time")+ 
  theme(plot.title = element_text(hjust = 0.5))

#------ BRKGA ------#
elite <-       c(.1,.25,.2,.1,.2,.25,.8,.4,.1)
mutant <-      c(.1,.3,.2,.2,.1,.1,.1,.4,.8)
Inheritance <- c(.5,.8,.6,.6,.8,.6,.9,.5,.1)
paramComb <- 1:9

brkgaresults <- c(69,70,70,68,68,69,78,75,76)
plot(x = brkgaresults,xlab = "parameters",ylab = "solution", main ="BRKGA Parameter Comparison", col = 'blue')

gDF <- data.frame(paramComb,brkgaresults)
ggplot(gDF, aes(paramComb)) +
  geom_line(aes(y=brkgaresults)) +
  geom_point(aes(y=brkgaresults)) +
  scale_x_continuous(breaks=paramComb) +
  ylab("solution")+xlab("parameter combination")+
  labs(title="BRKGA performance with varying parameters")+ 
  theme(plot.title = element_text(hjust = 0.5))

#------ GRASP ------#
alpha <- c(0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1.0)
graspResults <- c(65.27,66.7,66.36,66.36,64.5,65.36,63.5,84.18,74.6,82.7,71)

gDF <- data.frame(alpha,graspResults)
ggplot(gDF, aes(alpha)) +
      geom_line(aes(y=graspResults)) +
      geom_point(aes(y=graspResults)) +
      scale_x_continuous(breaks=alpha) +
      ylab("solution")+xlab("alpha")+
      labs(title="GRASP performance with varying alpha")+ 
      theme(plot.title = element_text(hjust = 0.5))
      


