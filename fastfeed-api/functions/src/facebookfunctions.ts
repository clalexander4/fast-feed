import * as functions from 'firebase-functions';
// import * from 'fb';

export const getFBdata = functions.https.onRequest((request, response) => {
  FB.api('4', function (res) {
    if(!res || res.error) {
     console.log(!res ? 'error occurred' : res.error);
     return;
    }
    console.log(res.id);
    console.log(res.name);
  });
});
