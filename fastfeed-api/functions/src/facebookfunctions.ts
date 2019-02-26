var options = FB.options();
var FB = require('fb'),
    fb = new FB.Facebook(options);

    FB.options({version: 'v2.4'});
    var fooApp = FB.extend({appId: 'foo_id', appSecret: 'secret'}),
        barApp = FB.extend({appId: 'bar_id', appSecret: 'secret'});
    var accessToken = FB.getAccessToken();
    console.log(accessToken);
    //FB.setAccessToken('EAATeoZCPkzmUBAHnv5S3MaEYTpO8ZBoi1gouuihAdlML7aBA1505UVddEmVfwJBYISgT7wio7PFbuu2p4yyXjEjquqN78dXSxZBbuCtAq5HHZBpHAYOCnLjH7DEEwtEtgTnl8daEmcbTDdRPgJ4KjRLZCrwQgFBtL0yHzqt6F0GiBrkAbdei70R7cA5EmbC4ZD');
