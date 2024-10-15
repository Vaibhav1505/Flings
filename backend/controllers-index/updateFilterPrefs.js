const decryptPayload = require('../helpers/decryptPayload');
const User = require('../schema/user');


module.exports = async function(req,res,next){

    let user = null;
    try{

        const {_id } = req.payload;

        
        const { filterPref } = req.body;

        console.log("Filter Pref",filterPref);

        
        user = await User.findByIdAndUpdate(_id,{
            $set:{
                filterPref
            }
        });

        if(user){
            res.status(200).end();
        }else{
            res.status(404).end();
        }
        



    }catch(e){
        console.log(e.message);
        res.status(500).end();
    }
}