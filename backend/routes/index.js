var express = require('express');
var router = express.Router();
const { verifyAccessToken } = require('../helpers/userAuthentication');
const { ENCODED_PUBLIC_KEY } = require('../helpers/rsa');

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/getKey', function (req, res, next) {
  res.json({ key: ENCODED_PUBLIC_KEY });
})

router.post('/generateCode', require('../controllers-index/generateCode'));

router.post('/authenticate', require('../controllers-index/authenticate'));

router.post('/updateMandatoryInfo', verifyAccessToken, require('../controllers-index/updateMandatoryInfo'));

router.post('/updateProfile', verifyAccessToken, require('../controllers-index/updateProfile'));

router.get('/getProfileStatus', verifyAccessToken, require('../controllers-index/getProfileStatus'));

router.post('/getPeopleList', verifyAccessToken, require('../controllers-index/getPeopleList'));

router.post('/performActionOnProfile', verifyAccessToken, require('../controllers-index/performActionOnProfile'));

router.post('/acceptUser', verifyAccessToken, require('../controllers-index/acceptUser'));

router.get('/getMatches', verifyAccessToken, require('../controllers-index/getMatches'));

router.post('/sendMessage', verifyAccessToken, require('../controllers-index/sendMessage'));

router.post('/getMessages', verifyAccessToken, require('../controllers-index/getMessages'));

router.post('/updateFilterPref', verifyAccessToken, require('../controllers-index/updateFilterPrefs'));

//Demo REST API Endpoints

// router.post('/getAllLatestMatches', verifyAccessToken, require('../controllers-index/getLatestMatches'))

// router.post('/addMessages', verifyAccessToken, require('../controllers-index/addMessages'))

module.exports = router;
