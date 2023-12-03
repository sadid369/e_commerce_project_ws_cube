const mongoose = require('mongoose'); // Erase if already required

// Declare the Schema of the Mongo model
var userSchema = new mongoose.Schema({
    name:{
        type:String,
        required:true,
        trim:true,
        
    },
    email:{
        type:String,
        required:true,
        trim:true,
        unique:true,
        validate:{
            validator:(value)=>{
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re)
            },
            message:'Please Enter a Valid Email Address'
        }
    },
    password:{
        type:String,
        required:true,
        
    },
    address:{
        type:String,
         default:"",
    },
    type:{
        type:String,
        default:'user',
    },
    //cart

});

//Export the model
const User = mongoose.model('User', userSchema);
module.exports = User;