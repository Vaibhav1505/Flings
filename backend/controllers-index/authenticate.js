const User = require("../schema/user");
const moment = require("moment");
const { signAccessToken } = require("../helpers/userAuthentication");
const JSEncrypt = require("nodejs-jsencrypt").default;
const decrypt = new JSEncrypt();
const { PRIVATE_KEY } = require("../helpers/rsa");
const { Buffer } = require("node:buffer");

decrypt.setPrivateKey(PRIVATE_KEY);

module.exports = function(req, res, next) {
    try {
        // const decrypted = decrypt.decrypt(req.body.payload);
        console.log(req.body);
        const { phone, candidateCode } = req.body;

        User.findOne({ phone }, {
                __v: 0,
                phone: 0,
                createdAt: 0,
                updatedAt: 0,
                acceptedUsers: 0,
                rejectedUsers: 0,
                blockedUsers: 0,
            },
            async function(err, user) {
                if (err) {
                    console.log(err.message);
                    return res.status(500).end();
                }

                if (user) {
                    const { value, generatedAt } = user.otp;

                    if (moment(generatedAt).diff(moment(), "minutes") < 5) {
                        if (candidateCode == value) {
                            const token = await signAccessToken({
                                _id: user._id,
                            });


                            let temp = JSON.parse(JSON.stringify(user));
                            delete temp.otp;
                            delete temp._id;

                            res.json({
                                accessToken: token,
                                userData: Buffer.from(JSON.stringify(temp)).toString("base64"),
                            });
                        } else {
                            return res.status(411).end(); //wrong CODE entered
                        }
                    } else {
                        return res.status(410).end(); //OTP time expired
                    }
                } else {
                    res.status(404).end();
                }
            }
        );
    } catch (e) {
        console.log(e.message);
        return res.status(500).end();
    }
};