const express = require('express')
const app = express()
const port = 3000

const ATC_USERNAME = process.env.ATC_USERNAME
const ATC_PASSWORD = process.env.ATC_PASSWORD

function render(username, password) {
    return '<html> \
        <head><title>ATC Assessment</title> \
        <body> \
            <p> ATC Username: ' + username + '</p> \
            <p> ATC Password: ' + password + '</p> \
        </body> \
        <head>'
}

app.get('/', (req, res) => {
  res.send(render(ATC_USERNAME, ATC_PASSWORD))
})

app.listen(port, () => {
  console.log(`ATC Assessment Simple Web Application running on ${port}`)
})