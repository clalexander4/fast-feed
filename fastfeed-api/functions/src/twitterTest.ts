import * as functions from 'firebase-functions';
import * as Twitter from 'twitter';

export const getFollowing = function (client: Twitter, response: functions.Response) {
    client.get('friends/list', { screen_name: "" }, function(error, tweets, res) {
        if (error) throw error;
        response.send({
            "tweets": tweets,
            "users": JSON.parse(res["body"])["users"]
        });
    });
}