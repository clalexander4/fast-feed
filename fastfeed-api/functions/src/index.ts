import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import makeRequest = require('request');
// import * as Twitter from 'twitter';
// import * as config from './config';
// import * as twtfunctions from './twtfunctions';

admin.initializeApp();
const db = admin.firestore();

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

export const saveToken = functions.https.onRequest((req, response) => {
    console.log(req.body.data);
    if ("token" in req.body.data && "uid" in req.body.data) {

        const basicAuthToken: string = Buffer.from("8huDE0vSDV4wKg:").toString("base64");

        console.log(basicAuthToken);

        makeRequest.post(
            `https://www.reddit.com/api/v1/access_token?grant_type=authorization_code&code=${req.body.data["token"]}&redirect_uri=fastfeed://redirect`,
            { headers: { 'Authorization': `Basic ${basicAuthToken}` } },
            function (error: any, res: any, body: any) {
                if (!error && res.statusCode === 200) {
                    const info = JSON.parse(body);
                    console.log(info);
                    if ("access_token" in info && "refresh_token" in info) {
                        console.log("saving tokens to database");
                        const userRef = db.doc(`users/${req.body.data["uid"]}`);
                        userRef.update({
                            access_token: info["access_token"],
                            refresh_token: info["refresh_token"]
                        }).then(() =>
                            response.send({
                                "data": {
                                    "success": true
                                }
                            })
                        ).catch(() => {
                            console.log("oof owie ouch couldn't write tokens to database");
                            response.send({
                                "data": {
                                    "success": false,
                                    "error": "yikes couldn't save to the database"
                                }
                            })
                        });
                    }
                    else {
                        console.log("so sad no tokens");
                        response.send({
                            "data": {
                                "success": false,
                                "error": "Invalid authorization code"
                            }
                        });
                    }
                }
                else {
                    console.log(error);
                    console.log(res);
                    response.send({
                        "data": {
                            "success": false,
                            "error": "Error asking Reddit for tokens"
                        }
                    });
                }
            });
    }
    else {
        response.send({
            "data": {
                "error": "Did not include necessary parameters"
            }
        });
    }
});