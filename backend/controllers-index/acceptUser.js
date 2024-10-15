const User = require('../schema/user');
const Match = require('../schema/match');
const mongoose = require('mongoose');

module.exports = async function (req, res, next) {


    let user = false;
    let match = false;
    let isMatch = false;
    let targetUser = false;


    try {

        const { _id } = req.payload;

        const { targetProfileId  } = req.body;
        

        if (targetProfileId == null) {
            return res.status(400).end();
        }

        if (!targetProfileId || !mongoose.isValidObjectId(targetProfileId)) {
            return res.status(400).json({ message: "Invalid target profile ID." });
        }


        user = await User.findById(_id);

        if (user) {

            // if target profile id provided is already blocked or rejectd by user then aport the operation
            if (user.rejectedUsers.includes(targetProfileId) || user.blockedUsers.includes(targetProfileId)) {
                return res.status(400).end();
            }


            // re initialising for reusing;
            user = false;

            targetUser = await User.findOne(
                {
                    $and: [
                        { _id: mongoose.Types.ObjectId(targetProfileId) },
                        { acceptedUsers: mongoose.Types.ObjectId(_id) }
                    ]
                });

            if (targetUser) {
                isMatch = true;

                match = await new Match({
                    users: [mongoose.Types.ObjectId(targetProfileId), mongoose.Types.ObjectId(_id)],
                    readBy: [mongoose.Types.ObjectId(_id)]
                }).save();

            }



            user = await User.findByIdAndUpdate(_id, {
                $addToSet: {
                    acceptedUsers: mongoose.Types.ObjectId(targetProfileId)
                }
            });

            if (user) {
                res.json({ isMatch });
            } else {
                return res.status(401).end();
            }





        } else {
            return res.status(404).end();
        }





    } catch (e) {
        console.log(e.message);
        return res.status(500).end();
    }
}