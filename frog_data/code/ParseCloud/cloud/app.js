var express = require('express');
var app = express();

app.get('/getindicators', function(req, res) {
	res.header("Access-Control-Allow-Origin", "*");
	res.header("Access-Control-Allow-Headers", "X-Requested-With");
	var query = new Parse.Query("indicator");
	query.limit(200);
	query.ascending("name");
	query.find({
		success: function(results) {
			res.send(results);
		},
		error: function() {
			res.send('Whoops, API is not available right now.');
		}
	});
});

app.get('/getdataset', function(req, res) {
	res.header("Access-Control-Allow-Origin", "*");
	res.header("Access-Control-Allow-Headers", "X-Requested-With");
	var query = new Parse.Query("value");
	var id = req.query.indid;
	query.limit(5000);
	query.ascending("period");
	if (id) {
		query.equalTo("indID", id);
		query.find({
			success: function(results) {
				res.send(results);
			},
			error: function() {
				res.send('Whoops, API is not available right now.');
			}
		});
	}
	else{
		res.send([]);
	}
});

// Attach the Express app to Cloud Code.
app.listen();
