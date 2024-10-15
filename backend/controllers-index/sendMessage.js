const Match = require('../schema/match');
const mongoose = require('mongoose');
const Chat = require('../schema/chat')
const {io} = require('../bin/www')

module.exports = async function (req, res, next) {
    const { _id } = req.payload; // Sender ID (from JWT)
    const { matchId, message, targetUserID } = req.body;
    console.log(req.body);

    const newChat = new Chat({
        message: message,
        senderId: mongoose.Types.ObjectId(_id),
        messageTimeStamp: new Date()
    });

    await newChat.save();

    Match.findById(matchId, (err, match) => {
        if (err || !match) {
            return res.status(404).json({ error: 'Match not found' });
        }



        // Store the message in DB
        match.chats.push(newChat._id);

        match.lastMessage = message;

        match.save((err) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to save message' });
            }

            // Emit the message only to the two matched users
            io.to(targetUserID).emit('getResponse', { message, from: _id });
            res.status(200).json({ success: 'Message sent successfully' });
        });
    });
};
