#import csv file
#create empty list to store total number of months, total amount of profit/losses over entire period
#list that tracks the changes in profit/losses over the entire period then gets the average of the changes
#list that has the greatest increase in profits with date and amount over the entire period
#list that has the greatest decrease in profits date and amount over the entire period
#sample
#Date,Profit/Losses
#Jan-10,1088983
#Date needs to be split on '-' to get months and day

import csv
import os
fpath = r"Module3\PyBank\Resources\budget_data.csv"
epath = r"Module3\PyPoll\Resources\election_data.csv"
#Declare variables

gDate = []
profitLoss = []
profitDiff = []
DiffIndex = []



with open(fpath, 'r', encoding='utf-8') as f: 

    reader = csv.reader(f, delimiter=',')
    #ignore header row
    next(reader)

    for row in reader: 
        #populate date from CSV into gdate list
        #populate profit loss from CSV into profitLoss list as an integer
        #print(row[0], row[1])
        gDate.append(row[0])
        profitLoss.append(int((row[1])))

    #need to find the greatest increase and greatest decrease
    #take the difference of the second value in the list from the first value 
    #keeping taking the difference until you get the end of the list
    
    for index in range(len(profitLoss)):
            if index+1 < len(profitLoss):
            
                Value = index + 1
                
                #get the values to compare
                firstValue = profitLoss[index]
                secondValue = profitLoss[Value]
                #get the difference of those values
                DiffValue = secondValue - firstValue
                #populate difference in profitDiff list
                #populate the date of the second value in DiffIndex list to be use to determine the date of greatest increase and greatest decrease
                profitDiff.append(DiffValue)
                DiffIndex.append(Value)
               
 
 

 
#get the number of items in gdate list to get the number of months      
NumofList = len(gDate)
#get the min of the profitDiff list to get the value for Greatest Decrease
MinofList = min(profitDiff)
#use the min value to find the index of the value in Profit Diff
Index_Min = profitDiff.index(MinofList) +1
#use the index from profit diff to find the corresponding date in gDate that matches taking into there are more elements in gdate than there are in profit
#Do the same process to get the max value and corresponding date for Greatest Increase
Min_Date = gDate[Index_Min]
MaxofList = max(profitDiff)
Index_Max = profitDiff.index(MaxofList)+1
Max_Date = gDate[Index_Max]
SumofList = sum(profitLoss)
sumDiff = sum(profitDiff)
lenDiff = len(profitDiff)
avgChange = round(sumDiff / lenDiff,2)
print("Financial Analyis\n"+final_divider)
print("Total Months:" + str(NumofList))
print("Total: $" + str(SumofList))
print("Average change is:" + str(avgChange))
print("Greatest Increase in Profits: " + str(Max_Date)+ " ($" + str(MaxofList)+")")
print("Greatest Decrease in Profits: " + str(Min_Date)+ " ($" + str(MinofList)+")" +"\n")


Cand=[]
County =[]
bID = []
unique_cand = []
cand_Votes = []




with open(epath, 'r', encoding='utf-8') as e: 

    reader = csv.reader(e, delimiter=',')
    #ignore header row
    next(reader)
    
    for row in reader: 
      
        bID.append(row[0])
        County.append(row[1])
        Cand.append(row[2])
        if row[2] not in unique_cand:
             unique_cand.append(row[2])


TotalVotes = len(Cand)

#print("Total votes is:" + str(len(Cand)))
#print("Unique Candidates: " + str(unique_cand))
count1 = 0
count2 = 0
count3 = 0
for x in Cand:
     if x == unique_cand[0]:
            count1 = count1 + 1
     elif x== unique_cand[1]:
            count2=count2 +1
     elif x == unique_cand[2]:
            count3=count3+1
cand_Votes.append(count1)
cand_Votes.append(count2)
cand_Votes.append(count3)

#print(count1,count2,count3)
#loop through candidates and get the vote percentage
final_cand = []
cand_ptg = []
for index in range(len(unique_cand)):
    vote_ptg =(cand_Votes[index] /TotalVotes)
    cand_ptg.append(vote_ptg)
    #print ("{:.3%}".format(vote_ptg))
    final_cand.append(unique_cand[index] + ": " +("{:.3%}".format(vote_ptg)) + " (" + str(cand_Votes[index]) + ")")

    #print(cand)
final_winner_ptg = max(cand_ptg)
final_index = cand_ptg.index(final_winner_ptg)
final_winner = unique_cand[final_index]

#print(final_winner_ptg, final_index, final_winner)

final_header = "Election Results"

print(final_header +"\n" + final_divider + "\nTotal Votes: " + str(TotalVotes)+"\n"+ final_divider)
for i in range(len(final_cand)):
    print(final_cand[i])
print(final_divider +"\nWinner: " + str(final_winner)+"\n"+ final_divider)
#output to text file




#          unique_cand.append(x)

#loop through candidates 

     






#print(profitLoss)


#census_final = zip(place, population, income, pcount)

#with open(write_fpath, 'w', newline='') as wf: 
#    writer = csv.writer(wf, delimiter=',')

#    writer.writerow(['Place', 'Population', 'Income', 'Poverty Count'])
#    writer.writerows(census_final)