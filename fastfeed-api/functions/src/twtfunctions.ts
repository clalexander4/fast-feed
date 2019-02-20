import * as functions from 'firebase-functions';
import * as Twitter from 'twitter';

export const getFollowing = function (client: Twitter, response: functions.Response) {
    client.get('friends/list', { screen_name: "LetThBigDougEat" }, function(error, tweets, res) {
        if (error) throw error;
        response.send({
            "tweets": tweets,
            "users": JSON.parse(res["body"])["users"]
        });
    });
}

export const searchTweets = function (client: Twitter, response: functions.Response){
    client.get('search/tweets', {q: 'Alabama Football'}, function(error, tweets, res) {
        if(error) throw error;
        response.send({
            "tweets": tweets
        });
     });
}

export const searchUsers = function (client: Twitter, response: functions.Response){
    client.get('search/users', {q: 'Jacoby Benger'}, function(error, users, res) {
        if(error) throw error;
        response.send({
            "users": users
        });
    });
}