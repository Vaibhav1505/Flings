const mongoose = require('mongoose')

const chatSchema = new mongoose.Schema({
    message: {
        type: String,
        required: true
    },
    senderId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true
    },
    messageTimeStamp: {
        type: Date,
        default: Date.now()
    }

}, {
    timestamps: true
})

const Chat = mongoose.model('Chat', chatSchema)

module.exports = Chat;