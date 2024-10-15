const decryptPayload = require("../helpers/decryptPayload");
const User = require("../schema/user");
const { Buffer } = require("node:buffer");

module.exports = async function(req, res, next) {
    let user = null;
    try {
        const { _id } = req.payload;
        console.log("req.payload:" + req.payload);

        // const { extra } = JSON.parse(Buffer.from(req.body.payload, 'base64').toString('ascii'))
        const extra = req.body;
        console.log("extra" + extra);

        user = await User.findByIdAndUpdate(_id, {
            $set: {
                extra,
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