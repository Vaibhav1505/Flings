const educationOptions = ["Bachelors","In College","High School","Intermediate","PhD","Masters"];
const drinkingOptions = ["Not for me","Sober","Sober curious","On special occassions","Socially on weekends","Most Nights"];
const smokingOptions = ["Social smoker","Smoker when drinking","Non-smoker","Smoker","Trying to quit"];
const workoutOptions = ["Everyday","Often","Sometimes","Never"];
const dietOptions = ["Vegan","Vegeterian","Pescatarian","Kosher","Halal","Carnivore","Omnivore","Other"];
const religionOptions = ["Agnostic","Athiest","Buddhist","Catholic","Christian","Hindu","Jain","Jewish","Mormon","Muslim","Zoroastrian","Sikh","Other"];
const politicalOptions= ["Apolitical","Moderate","Left","Right","Communist","Socialist"];
const socialMediaOptions=["Most of the day","Socially active","Not at all","Sometimes"];

const ageYear = [ 1990,1992,1996,2000,2002,2004,1994,1995,1991,1999];
const moment = require('moment');
const {faker} = require('@faker-js/faker');

const genders = ["m","f"];
const orientations = ["men","women","both"];

const mongoose = require('mongoose');
const mongooseOptions = { useNewUrlParser: true,useUnifiedTopology:true,autoIndex:false};
const mongooseConnectionString = "mongodb://localhost:27017/flings";
const User = require('./schema/user');


const locations = [
    [83.0016,25.3217],//Lahurabir Varanasi
    [82.9793,25.3047],//mehmoorgajn, varanasi
    [82.9864,25.3111],//sigra varanasi
    [80.9191,26.7837],//aashiyana lucknow,
    [81.8349,25.4529],//civil lines, prayagraj
    [82.9600,25.3551],//shivpur varanasi
    [83.0402,25.3313],// Rajghat varanasi
    [82.9979,25.2814]// Lanka Varanasi

]

// Setting up mongodb connection listeners
mongoose.connection.on('error',(err)=>{
    console.log('Error connecting with Mongodb:'+err.message);
  }).on('connecting',()=>{
    console.log('Connecting to mongodb...');
  }).on('connected',()=>{
    console.log(`Connection from Mongodb established`);
  }).on('disconnected',()=>{
    console.log('Connection lost from mongodb');
  })
  
  //Connecting to mongodb
  mongoose.connect(mongooseConnectionString,mongooseOptions)


async function createUsers(){

    for(let i=0;i<100;i++){
        let user = null;

        try{
            user = await new User( {
                "phone" : (Number("7881116410")+i).toString(),
                "__v" : 0,
                "acceptedUsers" : [],
                "blockedUsers" : [],
                "createdAt" : new Date(),
                "location": {
                    "type": "Point",
                    coordinates:locations[Math.floor(Math.random() * locations.length)]
                  },
                  "about":`I’m a good sucker!! 👅
                  Ohh especially the life part! 🤡😮‍💨`,
                "extra" : {
                    "height" : 150+Math.floor(Math.random() * 30),
                    "workout" : workoutOptions[Math.floor(Math.random() * workoutOptions.length)],
                    "education" : educationOptions[Math.floor(Math.random() * educationOptions.length)],
                    "drinking" : drinkingOptions[Math.floor(Math.random() * drinkingOptions.length)],
                    "smoking" : smokingOptions[Math.floor(Math.random() * smokingOptions.length)],
                    "religion" :religionOptions[Math.floor(Math.random() * religionOptions.length)],
                    "political" : politicalOptions[Math.floor(Math.random() * politicalOptions.length)],
                    "diet" : dietOptions[Math.floor(Math.random() * dietOptions.length)],
                    "socialMedia" : socialMediaOptions[Math.floor(Math.random() * socialMediaOptions.length)]
                },
                "filterPref" : {
                    "basic" : {
                        "age" : [],
                        "distance" : 80,
                        "gender" : null
                    },
                    "advanced" : {
                     
                    }
                },
                "otp" : {
                    "value" : "462050",
                    "generatedAt" : new Date()
                },
                "profileStatus" : 1,
                "rejectedUsers" : [],
                "updatedAt" : new Date(),
                "dob" : new Date(moment(`04-04-${ageYear[Math.floor(Math.random() * ageYear.length)]}`,"dd-mm-yyyy").toISOString()),
                "gender" : genders[Math.floor(Math.random() * genders.length)],
                "name" : faker.name.firstName(),
                "orientation" : orientations[Math.floor(Math.random() * orientations.length)]
            }).save();
            console.log("User "+i+" created");
        }catch(e){
            console.log("Error creating user "+i+" : "+e.message);
            
        }

        if(i===200){
            mongoose.disconnect();
        }
    }

}

createUsers();

