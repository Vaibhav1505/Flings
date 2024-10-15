const decryptPayload = require("../helpers/decryptPayload");
const User = require("../schema/user");
const moment = require("moment");

module.exports = async function(req, res, next) {
    console.log("Update Mandatory function starts");
    let user = null;
    try {
        const { _id } = req.payload;

        const { name, gender, dob, orientation } = req.body;

        user = await User.findByIdAndUpdate(_id, {
            $set: {
                name,
                gender,
                dob: new Date(moment(dob, "DD/MM/YYYY")),
                orientation,
                profileStatus: 1,
            },
        });

        if (user) {
            res.status(200).end();
        } else {
            res.status(404).end();
        }
    } catch (e) {
        console.log(e.message);
        res.status(500).end();
    }
};