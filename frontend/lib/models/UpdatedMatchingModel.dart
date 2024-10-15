import 'package:flings_flutter/models/ProfileModel.dart';

class UpdatedMatchModel {
  String? id;
  List<ProfileModel>? users; // Use ProfileModel for users
  List<ProfileModel>? readBy; // Use ProfileModel for readBy
  String? lastMessage;
  List<Chat>? chats;

  UpdatedMatchModel({
    this.id,
    this.users,
    this.readBy,
    this.lastMessage,
    this.chats,
  });

  UpdatedMatchModel.fromJson(Map<String, dynamic> json) {
   
    if (json['users'] != null) {
      users = <ProfileModel>[];
      json['users'].forEach((v) {
        users!.add(ProfileModel.fromJson(v)); // Convert to ProfileModel
      });
    }
    if (json['readBy'] != null) {
      readBy = <ProfileModel>[];
      readBy!.add(ProfileModel.fromJson(json['readBy'][0])); // Assuming only one user in readBy
    }
    lastMessage = json['lastMessage'];
    if (json['chats'] != null) {
      chats = <Chat>[];
      json['chats'].forEach((v) {
        chats!.add(Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['_id'] = id;
    }
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList(); // Convert ProfileModel back to JSON
    }
    if (readBy != null) {
      data['readBy'] = readBy!.map((v) => v.toJson()).toList(); // Convert ProfileModel back to JSON
    }
    data['lastMessage'] = lastMessage;
    if (chats != null) {
      data['chats'] = chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Chat {
  String? chatId;

  Chat({this.chatId});

  Chat.fromJson(Map<String, dynamic> json) {
    chatId = json['\$oid'];
  }

  Map<String, dynamic> toJson() {
    return {'\$oid': chatId};
  }
}