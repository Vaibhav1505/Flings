const JSEncrypt  = require('nodejs-jsencrypt').default;
const decrypt = new JSEncrypt();
const { PRIVATE_KEY } = require('./rsa');
decrypt.setPrivateKey(PRIVATE_KEY);

module.exports = function(payload){
    const decrypted = decrypt.decrypt(payload);

    return JSON.parse(decrypted);
}