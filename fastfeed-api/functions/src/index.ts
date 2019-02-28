import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
// import * as Twitter from 'twitter';
// import * as config from './config';
// import * as twtfunctions from './twtfunctions';
import * as fbfunctions from './facebookfunctions';


admin.initializeApp();
const db = admin.firestore();

var FB = require('fb');
FB.options({version: 'v2.4'});
FB.setAccessToken('EAATeoZCPkzmUBAJ5K7xQ5zqdNdpWCuvsAz0XdND2WtiktvdFQr6sQ2ZC3ZCw2r96aUeb0k30vZCU5pYnwZBUX3NV9mqNnubZCzG5yyoy51SXZBXEqAHHHWlieZCuJyXyBFnmZCoZBsnwSGGP6CCTq9L5bb4HPv6a3b3WQEJdxCc5cReu9VZB3Mxbdlitb045xc5qt0ZD');

export const getFacebookUserFeed = functions.https.onRequest((request, response) => {
    FB.id = '987160298144095';
    fbfunctions.getFbUserFeed(FB,response);
});
export const getFacebookLikes = functions.https.onRequest((request, response) => {
    FB.id = '10213329836548424';
    fbfunctions.getFbLikes(FB,response);
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