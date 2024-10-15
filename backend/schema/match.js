const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const matchSchema = new Schema(
  {
    users: {
      type: Array,
      default: []
    },
    readBy: {
      type: Array,
      default: []
    },
    lastMessage: {
      type: String,
      default: 'No Last Message'
    },
    chats: [{
      type: mongoose.Schema.Types.ObjectId,
      ref: "Chat",
     
    }]

  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("match", matchSchema);