const { meeting } = require('../schema/meeting');
const MeetingUser = require('../schema/meeting-user');
const { meetingUser } = require('../schema/meetingUser')
const mongoose = require('mongoose')


async function getAllMeetingUser(meetID, callback) {
    meetingUser.find({ meetingID: meetID })
        .then(
            (response) => {
                return callback(null, response);
            }
        )
        .catch((error) => {
            console.log(`Error in Getting all Meeting Users:${error.message}`);
            return callback(error)
        });
}


async function startMeeting(params, callback) {
    const meetingSchema = new meeting(params);
    meetingSchema
        .save()
        .then(
            (response) => {
                return callback(null, response)
            }
        )
        .catch((error) => {
            console.log(`Error in Start Meeting:${error.message}`)
            callback(error);
        })
}


async function joinMeeting(params, callback) {
    const meetingUserModel = new MeetingUser(params);
    meetingUserModel.save()
        .then(async (responnse) => {
            await meeting.findOneAndUpdate(
                {
                    id: params.meetingID
                },
                {
                    $addToSet: { "meetingUsers": meetingUserModel }
                })
            return callback(null, response);
        })
        .catch((error) => {
            console.log(`Error in Joining the Meeting:${error.message}`);
            callback(error);
        })

}

async function isMeetingPresent(meetingId, callback) {
    meeting.findById(meetingId)
        .populate("meetingUser", "MeetingUser")
        .then((response) => {
            if (!response) {
                callback("Invalid Meeting ID");
            } else {
                callback(null, true);
            }
        })
        .catch((error) => {
            return callback(error, false)
        })
}


async function checkMeetingExist(meetingId, callback) {
    meeting.findById(meetingId, "hostId", "hostName", "startTime")
        .populate("meetingUser", "MeetingUser")
        .then((response) => {
            if (!response) {
                callback("Invalid Meeting ID");
            } else {
                callback(null, true);
            }
        })
        .catch((error) => {
            return callback(error, false)
        })
}


async function getMeetingUser(params,callback){

}


