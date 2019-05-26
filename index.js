const http = require('http');
const express = require('express');
const path = require("path");
const shell = require('shelljs');

const app = express();
app.set('view engine');

app.use(express.static(__dirname));

app.get('/',function(req,res) {
  res.sendFile(path.join(__dirname + '/j_index.html'));
});

shell.echo('hello world');
const execute = shell.exec('./scr.sh');



const port = process.env.PORT || 1337;
app.listen(port);

console.log("Server running at http://localhost:%d", port);