import json
import csv
import urllib.request

print("This script will pull your cards from waffle.io and get their titles, description, and metadata to make a csv file and txt file for your sprint documentation")
print("Please provide your GitHub username and repo name to get waffle.io information:")
username = input("GitHub username: ")
repo = input("Repo name: ")

with open('input.json', 'r') as file:
    data = json.loads(urllib.request.urlopen("https://api.waffle.io/"+username+"/"+repo+"/cards").read().decode('utf8').replace("'", '"'))
    for item in data:
        item["description"] = json.loads(urllib.request.urlopen("https://api.github.com/repos/"+username+"/"+repo+"/issues/" + str(item["githubMetadata"]["number"])).read().decode('utf8').replace("'", '"'))["body"]
        item["comments"] = json.loads(urllib.request.urlopen("https://api.github.com/repos/"+username+"/"+repo+"/issues/" + str(item["githubMetadata"]["number"]) + "/comments").read().decode('utf8').replace("'", '"'))
    with open("sample.json", "w") as out:
        out.write(json.dumps(data))
    with open('ProjectBacklog.csv', 'w') as csvfile:
        filewriter = csv.writer(csvfile, delimiter=',',
                                quotechar='|', quoting=csv.QUOTE_MINIMAL)
        filewriter.writerow(['ID','Story','Estimation (hours)','Priority','Sprint When Finished'])
        for item in data:
            milestone = "n/a"
            if "milestone" in item["githubMetadata"]:  
                milestone = item["githubMetadata"]["milestone"]["title"]
            filewriter.writerow([item["githubMetadata"]["title"],milestone,item["githubMetadata"]["number"],"1","1"])
    with open('SprintGoalBacklog.txt', 'w') as txtfile:
        for item in data:
            if not item["description"]:
                item["description"] = "no description"
            txtfile.write("•" + item["githubMetadata"]["title"]+"\n"+item["description"])
            for comment in item["comments"]:
                txtfile.write("\n\t>" + comment["body"].replace("\n", "\n\t") + "\n")
            txtfile.write("\n\n")
print("Created ProjectBacklog.csv and SprintGoalBacklog.txt")