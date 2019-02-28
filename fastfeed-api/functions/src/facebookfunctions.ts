import * as functions from 'firebase-functions';

export const getFbLikes = function (FB: any,response: functions.Response) {
  FB.api(FB.id, { fields: ['id','name', 'likes'] }, function (res:any) {
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
export const getFbUserFeed = function (FB: any,response: functions.Response) {
  FB.api(FB.id, { fields: ['posts','picture'] }, function (res:any) {
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