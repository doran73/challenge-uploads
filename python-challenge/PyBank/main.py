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
fpath = os.path.join( "Resources", "budget_data.csv")
#print(fpath)
#fpath = "Resources\budget_data.csv'
#C:\Users\DoranRainford\OneDrive - Crimson Transaction Technologies\Documents\GitHub\challenge-uploads\challenge-uploads\python-challenge\PyBank\Resources\budget_data.csv

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
#put display output in list
final_output = []

final_divider = "-------------------------"  
final_output.append("Financial Analyis\n"+final_divider)
final_output.append("Total Months: " + str(NumofList))
final_output.append("Total: $" + str(SumofList))
final_output.append("Average change is:" + str(avgChange))
final_output.append("Greatest Increase in Profits: " + str(Max_Date)+ " ($" + str(MaxofList)+")")
final_output.append("Greatest Decrease in Profits: " + str(Min_Date)+ " ($" + str(MinofList)+")" +"\n")
#path and name of the text file that will contain the analysis
opath = os.path.join( "Analysis", "budget_data.txt")
#output display output
for lines in final_output:
    print(lines)
#create text file with final output
with open(opath,'w') as f:
       
    f.write('\n'.join(final_output))



