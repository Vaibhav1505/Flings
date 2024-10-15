const User = require('../schema/user');
const mongoose = require('mongoose');

module.exports = async function (req, res, next) {




    try {
        const { _id } = req.payload;
        console.log("Req.payload" + JSON.stringify(req.payload));
        const { latitude, longitude } = req.body;
        console.log("req body" + JSON.stringify(req.body));
        let acceptedUsers = [];
        let rejectedUsers = [];
        let blockedUsers = [];


        if (!latitude || !longitude) {
            return res.status(400).json({ message: "Latitude and longitude are required." });
        }

        let user = await User.findById(_id, { filterPref: 1, acceptedUsers: 1, rejectedUsers: 1, blockedUsers: 1 });

        let basic = {};
        let advanced = {};

        if (user) {
            basic = user.filterPref.basic;
            advanced = user.filterPref.advanced;
            acceptedUsers = user.acceptedUsers;
            rejectedUsers = user.rejectedUsers;
            blockedUsers = user.blockedUsers;
        } else {
            return res.status(404).end();
        }

        User.aggregate([
            // {
            //     "$geoNear": {
            //         "near": {
            //             "type": "Point",
            //             "coordinates": [longitude, latitude]
            //         },
            //         "distanceField": "distance",
            //         "maxDistance": (basic.distance !== null ? basic.distance : 100) * 1000,
            //         "spherical": true,
            //         "key": "location"
            //     }
            // },


            {
                $addFields: {
                    age: {
                        $round: [{
                            $divide: [{ $subtract: [new Date(), "$dob"] },
                            (365 * 24 * 60 * 60 * 1000)
                            ]
                        }, 0]
                    },


                },

            },
            {
                $match: {
                    $and: [
                        { age: { $gte: basic.ageRange[0] } },
                        { age: { $lte: basic.ageRange[1] } },
                        { _id: { $nin: acceptedUsers } },
                        { _id: { $nin: rejectedUsers } },
                        { _id: { $nin: blockedUsers } },
                        { _id: { $ne: mongoose.Types.ObjectId(_id) } }
                    ],
                }
            },
            {
                $limit: 10
            },
            {
                $project: {
                    name: 1,
                    age: 1,
                    gender: 1,
                    phone: 1,
                    distance: { $round: { $divide: ["$distance", 1000] } },
                    extra: 1,
                    about: 1
                }
            }

        ]
            , function (err, users) {
                if (err) {
                    console.log("Error:" + err.message);
                    return res.status(500).end();
                }

                console.log(users);
                res.json(users);
            })


    } catch (e) {
        console.log(e.message);
        return res.status(500).end();
    }
}