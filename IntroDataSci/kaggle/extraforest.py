import csv as csv 
import numpy as np

#Open up the csv file in to a Python object
csv_file_object = csv.reader(open('./train.csv', 'rb')) 
header = csv_file_object.next()  #skip header

data=[]                          #Create a variable called 'data'
for row in csv_file_object:      #Run through each row in the csv file
    data.append(row)             #adding each row to the data variable
data = np.array(data)           

'''
columns:
0: survived
1: pclass
2: sex
3: age
4: siblings
5: parent/children
6: fare
7: embarked
'''
def filterData(data, add = 0):
    data = np.delete(data, np.s_[2 + add:3 + add:], 1)
    data = np.delete(data, np.s_[6 + add:7 + add:], 1)
    data = np.delete(data, np.s_[7 + add:8 + add:], 1)
    
    for row in data:
        if row[2+ add] == "female":
            row[2+ add] = 1
        elif row[2+ add] == "male":
            row[2+ add] = 2
        else:
            row[2+ add] = 3 #unknown
        
        #trying to make best guesses for incomplete data
        #age
        if row[3+add] == "":
            row[3+add] = 3 #unknown
        elif float(row[3+add]) < 17:
            row[3+add] = 1
        else:
            row[3+add] = 2

        #siblings
        if row[4+add] == "":
            row[4+add] = 2 #unknown
        elif float(row[4+add]) > 0:
            row[4+add] = 1
        else:
            row[4+add] = 0

        #parent
        if row[5+add] == "":
            row[5+add] = 2 #unknown
        elif float(row[5+add]) > 0:
            row[5+add] = 1
        else:
            row[5+add] = 0
            
        #price paid / if not present derive from class
        '''if row[6+add] == "":
            if row[1+add] == 1:
                row[6+add] = 80
            elif row[1+add] == 2:
                row[6+add] = 21;
            else:
                row[6+add] = 13 '''
        if row[6+add] == "":
            if row[1+add] == 1:
                row[6+add] = 1
            else:
                row[6+add] = 2
        
        #embardk            
        if row[7+ add] == "":
            row[7+ add] = 3 #unknown
        elif row[7+ add] == "C":
            row[7+ add] = 1
        else:
            row[7+ add] = 2
    return data
    
data = filterData(data, 0);
print data[0:3]

from sklearn.ensemble import ExtraTreesClassifier 

# Create the random forest object which will include all the parameters
# for the fit
Forest = ExtraTreesClassifier(n_estimators = 1000)

# Fit the training data to the training output and create the decision
# trees
Forest = Forest.fit(data[0::,1::],data[0::,0])

test_file_obect = csv.reader(open('./test.csv', 'rb'))
header = test_file_obect.next()
test_data=[]                          #Create a variable called 'data'
for row in test_file_obect:      #Run through each row in the csv file
    test_data.append(row)             #adding each row to the data variable
test_data = np.array(test_data)   

test_data = filterData(test_data, -1);
# Take the same decision trees and run on the test data
output = Forest.predict(test_data)

    
open_file_object = csv.writer(open("./forestmodel.csv", "wb"))    

#open_file_object.writerow(header)

for i, row in enumerate(test_data):
    row = np.insert(row, 0, output[i])
    open_file_object.writerow(row)   