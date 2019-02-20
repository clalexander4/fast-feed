from json import loads
import csv

with open('input.json', 'r') as file:
    data = file.read().replace('\n', '')
    with open('output.csv', 'wb') as csvfile:
        filewriter = csv.writer(csvfile, delimiter=',',
                                quotechar='|', quoting=csv.QUOTE_MINIMAL)
        filewriter.writerow(['ID','Story','Estimation (hours)','Priority','Sprint When Finished'])
        for item in loads(data):
            print(item)
            milestone = "n/a"
            if "milestone" in item["githubMetadata"]:  
                milestone = item["githubMetadata"]["milestone"]["title"]
            filewriter.writerow([item["githubMetadata"]["title"],milestone,item["githubMetadata"]["number"],"1","1"])
