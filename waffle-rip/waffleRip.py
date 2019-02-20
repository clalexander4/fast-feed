import json
import csv
import urllib.request

with open('input.json', 'r') as file:
    data = json.loads(urllib.request.urlopen("https://api.waffle.io/damccoy1/fast-feed/cards").read().decode('utf8').replace("'", '"'))
    with open('ProjectBacklog.csv', 'w') as csvfile:
        filewriter = csv.writer(csvfile, delimiter=',',
                                quotechar='|', quoting=csv.QUOTE_MINIMAL)
        filewriter.writerow(['ID','Story','Estimation (hours)','Priority','Sprint When Finished'])
        for item in data:
            print(item)
            milestone = "n/a"
            if "milestone" in item["githubMetadata"]:  
                milestone = item["githubMetadata"]["milestone"]["title"]
            filewriter.writerow([item["githubMetadata"]["title"],milestone,item["githubMetadata"]["number"],"1","1"])
