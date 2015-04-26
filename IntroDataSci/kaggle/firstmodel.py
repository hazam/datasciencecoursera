import csv as csv 
import numpy as np

#Open up the csv file in to a Python object
csv_file_object = csv.reader(open('./train.csv', 'rb')) 
header = csv_file_object.next()  #skip header

data=[]                          #Create a variable called 'data'
for row in csv_file_object:      #Run through each row in the csv file
    data.append(row)             #adding each row to the data variable
data = np.array(data)           


number_passengers = np.size(data[0::,0].astype(np.float))
number_survived = np.sum(data[0::,0].astype(np.float))      #sum because survived passenger have a 1 
proportion_survivors = number_survived / number_passengers

print 'passengers {0}, survived {1}, percentage {2}'.format(number_passengers, number_survived, proportion_survivors)

women_only_stats = data[0::,3] == "female"  #filtering for sublists
men_only_stats = data[0::,3] == "male"

#Using the index from above we select the females and males separately
women_onboard = data[women_only_stats,0].astype(np.float)     
men_onboard = data[men_only_stats,0].astype(np.float)

# Then we finds the proportions of them that survived
proportion_women_survived = np.sum(women_onboard) / np.size(women_onboard)  
proportion_men_survived = np.sum(men_onboard) / np.size(men_onboard) 

#and then print it out
print 'Proportion of women who survived is %s' % proportion_women_survived
print 'Proportion of men who survived is %s' % proportion_men_survived

test_file_obect = csv.reader(open('./test.csv', 'rb'))
header = test_file_obect.next()

open_file_object = csv.writer(open("./genderbasedmodelpy.csv", "wb"))

for row in test_file_obect:       
    if row[2] == 'female':           
        row.insert(0,'1')            
        open_file_object.writerow(row)
    else:                             
        row.insert(0,'0')           
        open_file_object.writerow(row) 