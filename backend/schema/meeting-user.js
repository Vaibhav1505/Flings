const mongoose = require('mongoose');

const meetingUserSchema = new mongoose.Schema({
    socketID: {
        type: String,
    },

    meetingID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Meeting"
    },
    UserID: {
        type: String,
        required: true
    },
    joined: {
        type: Boolean,
        required: true
    },
    name: {
        type: String,
        required: true
    },
    isAlive: {
        type: Boolean,
        required: true
    },

}, {
    timestamps: true
})

const MeetingUser = mongoose.model('MeetingUser', meetingUserSchema);

module.exports = MeetingUser;