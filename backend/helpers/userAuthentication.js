const JWT = require('jsonwebtoken');
const createError = require('http-errors')
let { v4: uuidv4 } = require('uuid');

const ACCESS_TOKEN_SECRET = `MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGWmJonqF90EpI9qTUiTK//Uk9XI
OWauYNNpVjOqHrJ5PwSNHsrd0ncNisObnCh0y027vjbqlkFNVSGBrWxF6+VgwBNs
iC6ZSnIxzc2pHyY+eKZvHgDib2XPn948Hpl4XMZndO6Kq+FmtsNjc4JILve/056T
otRod6YApFYI0/XZAgMBAAE=`;


module.exports = {
    signAccessToken: ({ _id }) => {
        return new Promise((resolve, reject) => {
            const payload = {
                _id

            }
            const secret = ACCESS_TOKEN_SECRET
            const options = {
                issuer: 'flings.com',
                audience: _id.toString()
            }

            JWT.sign(payload, secret, options, (err, token) => {
                if (err) reject(err)
                resolve(token);
            })
        })
    },
    signRefreshToken: (user_id) => {
        return new Promise((resolve, reject) => {
            const payload = {
                user_type: "merchant",
                user_uuid: uuidv4(),

            }
            const secret = process.env.REFRESH_TOKEN_SECRET;
            const options = {
                expiresIn: '1y',
                issuer: 'merchant.lufy.com',
                audience: user_id
            }

            JWT.sign(payload, secret, options, (err, token) => {
                if (err) reject(err)
                resolve(token);
            })
        })
    },
    verifyAccessToken: (req, res, next) => {
        try {

            const token = req.headers.authorization.split(" ")[1];
            //const token = req.body.token;    


            if (!token)
                return res.status(401).end('Unauthorized');

            const secret = ACCESS_TOKEN_SECRET


            JWT.verify(token, secret, (err, payload) => {
                if (err) {
                    console.log(err.message);
                    return res.status(401).end('Unauthorized');
                }

                req.payload = payload;
                next();
            });




        } catch (err) {
            console.log(err.message);
            res.status(401).end('Unauthorized');
        }
    }
}