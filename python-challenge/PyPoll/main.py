import os
import csv

#Declare Variables
Cand=[]
County =[]
bID = []
unique_cand = []
cand_Votes = []
#file path where the csv is
epath = os.path.join( "Resources", "election_data.csv")



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
final_output = []
#print(final_winner_ptg, final_index, final_winner)

final_header = "Election Results"
final_divider = "-------------------------" 
final_output.append(final_header +"\n" + final_divider + "\nTotal Votes: " + str(TotalVotes)+"\n"+ final_divider)
for i in range(len(final_cand)):
    final_output.append(final_cand[i])
final_output.append(final_divider +"\nWinner: " + str(final_winner)+"\n"+ final_divider)
#output to text file
#path and name of the text file that will contain the analysis
opath = os.path.join( "Analysis", "election_data.txt")
#output display output
for lines in final_output:
    print(lines)
#create text file with final output
with open(opath,'w') as f:
       
    f.write('\n'.join(final_output))




     






#print(profitLoss)


#census_final = zip(place, population, income, pcount)

#with open(write_fpath, 'w', newline='') as wf: 
#    writer = csv.writer(wf, delimiter=',')

#    writer.writerow(['Place', 'Population', 'Income', 'Poverty Count'])
#    writer.writerows(census_final)