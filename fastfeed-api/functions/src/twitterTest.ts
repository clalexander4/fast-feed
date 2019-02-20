// import * as functions from 'firebase-functions';
// import * as Twitter from 'twitter';
// import * as config from './config';
// import * as twtfunctions from './twtfunctions';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//

// var client = new Twitter({
//     consumer_key: config.twitterKeys["consumer_key"],
//     consumer_secret: config.twitterKeys["consumer_secret"],
//     access_token_key: config.twitterKeys["access_token_key"],
//     access_token_secret: config.twitterKeys["access_token_secret"]
//   });

//Application Only Authentication - Public Data only 
// var client = new Twitter({
//     consumer_key: config.twitterKeys["consumer_key"],
//     consumer_secret: config.twitterKeys["consumer_secret"],
//     bearer_token: config.twitterKeys["bearer_key"]
// });

// export const searchTweets = functions.https.onRequest((request, response) => {
//     twtfunctions.searchTweets(client, response);
// });