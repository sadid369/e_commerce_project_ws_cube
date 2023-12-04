const express = require('express')
const User = require('../models/user')
const bcryptjs = require('bcryptjs')
//signUp Route
const authRouter = express.Router();
 authRouter.post('/api/signup' ,async (req , res)=>{
 try {
    const {name, email, password} = req.body;
    const exitingUser =await  User.findOne({email})
    if(exitingUser){
      return res.status(400).json({msg:'User with this email already exists!'})  
    }
    const hashedPassword =await bcryptjs.hash(password, 8);
    let user = new User({
        name,
        email,
        password: hashedPassword
    })
    
    user =await user.save();
    
    res.json(user)
 } catch (e) {
    res.status(500).json({error:e.message})
 }

});
// authRouter.get('/' , (req , res)=>{

//    res.send('hello from simple server :)')

// })

module.exports = authRouter;


