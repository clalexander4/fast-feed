import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
// import * as Twitter from 'twitter';
// import * as config from './config';
// import * as twtfunctions from './twtfunctions';
import * as fbfunctions from './facebookfunctions';


admin.initializeApp();
const db = admin.firestore();

export const getFacebookUserFeed = functions.https.onRequest((request, response) => {
    fbfunctions.getFbUserFeed(response);
});
export const getFacebookLikes = functions.https.onRequest((request, response) => {
    fbfunctions.getFbLikes(response);
});

// var client = new Twitter({
//     consumer_key: config.twitterKeys["consumer_key"],
//     consumer_secret: config.twitterKeys["consumer_secret"],
//     access_token_key: config.twitterKeys["access_token_key"],
//     access_token_secret: config.twitterKeys["access_token_secret"]
//   });

// export const getTwitterFollowing = functions.https.onRequest((request, response) => {
//     twtfunctions.getFollowing(client, response);
// });

export const helloWorld = functions.https.onRequest((request, response) => {
    console.log(request.body.data);
    if ("name" in request.body.data) {
        response.send({ 
            "data": {
                "message": `Sup ${request.body.data["name"]}!`
            }
        });
    }
    else {
        response.send({
            "data": {
                "error": "No name was provided"
            }
        });
    }
});

export const createUserRecord = functions.auth
    .user()
    .onCreate((user, context) => {
        const userRef = db.doc(`users/${user.uid}`);

        return userRef.set({
            email: user.email,
            createdAt: context.timestamp,
            uid: user.uid
        });
    });