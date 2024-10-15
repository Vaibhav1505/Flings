const Match = require('../schema/match');
const mongoose = require('mongoose');

module.exports = function(req,res,next){

    try{
        const {_id } = req.payload;
        const {matchId,skip} = req.body;

        Match.aggregate([
            {
                $match:{_id:mongoose.Types.ObjectId(matchId)}
            },
            {
                $project:{
                    chats:1
                }
            },
            {
                $unwind:"$chats"
            },
            {
                $replaceRoot:{
                    newRoot:"$chats"
                }
            },
            {
                $group:{
                    _id:{                    
                        day: { $dateToString: { format: "%d", date: "$time" } },
                        month:{$dateToString: { format: "%m", date: "$time" }},
                        year:{$dateToString: { format: "%Y", date: "$time" }}
                    },
                    messages:{$push:{
                        time:'$time',
                        sender:{
                        $cond:{
                            if:{$eq:["$senderId",mongoose.Types.ObjectId(_id)]},then:"right",else:'left'
                        }
                    },message:'$message'}}
                }
            }
           
        ],function(err,chats){
            if(err){
                console.log(err.message);
                return res.status(500).end();
            }

            try{
                console.log(chats[0]);

                res.json(chats);
            }catch(e){
                console.log(e.message);
                res.json([]);
            }
        })
        
    }catch(e){
        console.log(e.message);
        return res.status(500).end();
    }
}