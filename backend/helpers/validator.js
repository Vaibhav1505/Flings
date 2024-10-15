const alpha = /^[a-zA-Z-,]+(\s{0,1}[a-zA-Z-, ])*$/
const validator = require('validator');

module.exports = {
    validateName:(str)=>{
        return alpha.test(str)&&validator.isLength(str,{min:3,max:25});
    },
    isValidPhone:(str)=>{
        return validator.isNumber(str)&&validator.isLength(str,{min:10,max:10})
    },
    isValidPassword:(str)=>{
        return validator.isLength(str,{min:8,max:16})
    }
}