const mongoose = require("mongoose");
const Schema = mongoose.Schema;


const filterPrefs = {
  basic: {
    ageRange: { type: Array, default: [18, 80] },
    distance: { type: Number, default: 80 },
    gender: { type: String, defautl: null, }
  },
  advanced: {
    height: { type: Number, default: null },
    workout: { type: Array, default: [] },
    education: { type: Array, default: [] },
    drinking: { type: Array, default: [] },
    smoking: { type: Array, default: [] },
    religion: { type: Array, default: [] },
    political: { type: Array, default: [] },
    diet: { type: Array, default: [] },
    currentCity: { type: Array, default: [] },
    hometown: { type: Array, default: [] },
    socialMedia: { type: Array, default:[] }
  }
}

const extra = {
  about: { type: String, default: null, maxLength: 300 },
  job: { type: String, default: null },
  company: { type: String, default: null },
  currentCity: { type: String, default: null },
  hometown: { type: String, default: null },

  height: { type: Number, default: null },
  workout: { type: String, default: null },
  education: { type: String, default: null },
  drinking: { type: String, default: null },
  smoking: { type: String, default: null },
  religion: { type: String, default: null },
  political: { type: String, default: null },
  diet: { type: String, default: null },
  socialMedia: { type: String, default: null }
}



const userSchema = new Schema(
  {
    name: { type: String },
    phone: { type: String, required: true },
    location: {
      type: { type: String },
      coordinates: [Number],
    },
    premium:{
      enabled:{type:String,default:false},
      msg:{type:Number,default:0},
      expiresOn:{type:Date}
    },
    email: { type: String },
    dob: { type: Date },
    rejectedUsers: { type: Array },
    blockedUsers: { type: Array },
    acceptedUsers: { type: Array },
    profileStatus: { type: Number, default: 0 },
    gender: { type: String },
    orientation: { type: String },
    about: { type: String, default: null },

    filterPref: filterPrefs,


    extra: extra,


    otp: {
      value: { type: String },
      generatedAt: { type: Date }
    }

  },
  {
    timestamps: true,
  }
);

userSchema.index({ location: '2dsphere' });




module.exports = mongoose.model("User", userSchema);