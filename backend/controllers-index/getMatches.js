const Match = require('../schema/match');
const mongoose = require('mongoose');

module.exports = function (req, res, next) {

    try {

        const { _id } = req.payload;
        Match.aggregate([
            {
                $project: {
                    chats: 0
                }
            },
            {
                $match: {
                    users: mongoose.Types.ObjectId(_id)
                }
            },
            {
                $addFields: {
                    targetUserId: {
                        $arrayElemAt: [{
                            $filter: {
                                input: '$users',
                                as: 'userList',
                                cond: {
                                    $ne: [
                                        "$$userList", mongoose.Types.ObjectId(_id)
                                    ]
                                }
                            }
                        }, 0]
                    }
                }
            },
            {
                $lookup: {
                    from: 'users',
                    localField: 'targetUserId',
                    foreignField: '_id',
                    as: 'targetUserInfo'
                }
            },
            {
                $unwind: '$targetUserInfo'
            },
            {
                $project: {
                    userId: '$targetUserInfo._id',
                    userName: '$targetUserInfo.name',
                    gender: '$targetUserInfo.gender',
                    lastMessage: '$lastMessage'
                }
            }

        ], function (err, matches) {
            if (err) {
                console.log(err.message);
                return res.status(500).end();
            }

            try {
                
                res.json(matches);
            } catch (e) {
                console.log(e.message);
                res.json([]);
            }
        })


    } catch (e) {
        console.log(e.message);
        return res.status(500).end();
    }
}