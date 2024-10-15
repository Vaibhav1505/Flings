const generateCode = require("../helpers/generateCode");
const User = require("../schema/user");

const JSEncrypt = require("nodejs-jsencrypt").default;
const decrypt = new JSEncrypt();
const { PRIVATE_KEY } = require("../helpers/rsa");
decrypt.setPrivateKey(PRIVATE_KEY);

module.exports = function (req, res, next) {
  try {
    const { phone, userLocation } = req.body;

    const [longitude, latitude] = userLocation;

    console.log(`Latitude:${JSON.stringify(latitude)} and Longitude:${JSON.stringify(longitude)}`)

    if (latitude == null || longitude == null || isNaN(latitude) || isNaN(longitude)) {
      return res.status(400).json({
        error: "Invalid location data.",

      });
    }

    console.log('Request Body:' + req.body);

    User.findOneAndUpdate(
      { phone },
      {
        $set: {
          location: {
            type: "Point",
            coordinates: [longitude,latitude],
          },
          otp: {
            value: generateCode(),
            generatedAt: new Date(),
          },
        },
      },
      { setDefaultsOnInsert: true, upsert: true, new: true },
      function (err, updatedUser) {
        if (err) {
          console.log(err.message);
          return res.status(500).json({
            error: err
          });
        }

        if (updatedUser) {
          res.status(200).json({
            userData: updatedUser
          });
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
