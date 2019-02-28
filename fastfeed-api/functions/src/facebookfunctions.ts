import * as functions from 'firebase-functions';

export const getFbLikes = function (response: functions.Response) {
  var FB = require('fb');
  FB.options({version: 'v2.4'});
  FB.setAccessToken('EAATeoZCPkzmUBAJ8X9PlC88N9qqSZAEMChY9TsgaOyflqPYo1DMPzmKGXrSQevE6s6zbFkBmSSWvjiPqyuIbK6ZBZCsJUMJKyMOp1M5JCZBSW9SXDaBT1AiHZBsJbwEQj0Okq8QB3ZAyXjYoZBBIZAEndONLu7ZCh7IdfQlUC7ko47J3Rx3iJ7ZAcGLkMuZA8kyL2BcZD');
  FB.api('10213329836548424', { fields: ['id','name', 'likes'] }, function (res:any) {
      if(!res || res.error) {
      console.log(!res ? 'error occurred' : res.error);
      response.send({
          "data": {
              "success": false
          }
      });
      }
      response.send({
          "data": {
              "id": res.id,
              "name": res.name,
              "likes" : res.likes.data
          }
      });
  });
};
export const getFbUserFeed = function (response: functions.Response) {
  var FB = require('fb');
  FB.options({version: 'v2.4'});
  FB.setAccessToken('EAATeoZCPkzmUBAJ8X9PlC88N9qqSZAEMChY9TsgaOyflqPYo1DMPzmKGXrSQevE6s6zbFkBmSSWvjiPqyuIbK6ZBZCsJUMJKyMOp1M5JCZBSW9SXDaBT1AiHZBsJbwEQj0Okq8QB3ZAyXjYoZBBIZAEndONLu7ZCh7IdfQlUC7ko47J3Rx3iJ7ZAcGLkMuZA8kyL2BcZD');
  FB.api('987160298144095', { fields: ['posts','picture'] }, function (res:any) {
      if(!res || res.error) {
      console.log(!res ? 'error occurred' : res.error);
      response.send({
          "data": {
              "success": false
          }
      });
      }
      response.send({
          "posts": {
              "data" : res.posts.data
          }
      });
  });
};