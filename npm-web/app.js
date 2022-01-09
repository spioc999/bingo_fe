const express = require('express')
const app = express()

app.get('/', (req, res) => {
    res.sendFile('public-flutter/index.html',{root:__dirname})
  })

app.use(express.static(__dirname + '/public-flutter'))

app.use((req, res)=>{
    res.redirect('/')
})

app.listen(5555, () => {
    console.log(`Server started on port 5555`)
  })