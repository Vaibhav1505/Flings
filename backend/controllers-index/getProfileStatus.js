const User = require('../schema/user');

module.exports = async function(req,res,next){

    let user = null;

    try{

        
        const { _id } = req.payload;

        user = await User.findById(_id,{phone:0,createdAt:0,updatedAt:0,otp:0,acceptedUsers:0,rejectedUsers:0,blockedUsers:0});

        if(user){
            res.json(user);
        }else{
            return res.status(404).end();
        }
    

    }catch(e){
        console.log(e.message);

        return res.status(500).end();
    }
}