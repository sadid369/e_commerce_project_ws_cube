const express = require('express')
const mongoose = require('mongoose')
const app = express()
const authRouter = require('./routes/auth')
require('dotenv').config()
const port = process.env.PORT || 5000

app.use(express.json())
app.use(authRouter)

mongoose.connect(process.env.DB).then(()=>{
    console.log('Connection Successful');
}).catch((e)=>{
    console.log(e);
})

app.listen(port ,"0.0.0.0", ()=> console.log(`> Server is up and running on port :   ${port}`))