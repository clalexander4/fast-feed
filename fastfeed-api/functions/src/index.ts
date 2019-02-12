import * as functions from 'firebase-functions';
import * as Twitter from 'twitter';
import * as config from './config';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//

var client = new Twitter({
    consumer_key: config.twitterKeys["consumer_key"],
    consumer_secret: config.twitterKeys["consumer_secret"],
    access_token_key: config.twitterKeys["access_token_key"],
    access_token_secret: config.twitterKeys["access_token_secret"]
  });

export const getTwitterFollowing = functions.https.onRequest((request, response) => {
    client.get('friends/list', { screen_name: "rtrPAWLfan" }, function(error, tweets, res) {
        if (error) throw error;
        response.send({
            "tweets": tweets,
            "users": JSON.parse(res["body"])["users"]
        });
    });
});

export const helloWorld = functions.https.onRequest((request, response) => {
    if ("name" in request.body) {
        response.send({ 
            "message": `Sup ${request.body["name"]}!`
        });
    }
    else {
        response.send({
            "error": "No name was provided"
        });
    }
});
