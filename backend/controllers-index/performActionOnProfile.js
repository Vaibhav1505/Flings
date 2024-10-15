const User = require('../schema/user');
const mongoose = require('mongoose');

module.exports = function(req,res,next){

    
    try{

        const { _id } = req.payload;

        const { profileId=null , action=null } = req.body;

        if(profileId==null || action == null){
            return res.status(400).end();
        }

        let map = {
            "accept":"acceptedUsers",
            "reject":"rejectedUsers",
            "block":"blockedUsers"
        }

        User.findByIdAndUpdate(_id,{
            $addToSet:{
                [map[action]]:mongoose.Types.ObjectId(profileId)
            }
        },function(err,user){
            if(err){
                console.log(err.message);
                return res.status(500).end();
            }

            if(user){
                res.status(200).end();
            }else{
                res.status(404).end();
            }
        })



    }catch(e){
        console.log(e.message);
        return res.status(500).end();
    }
}