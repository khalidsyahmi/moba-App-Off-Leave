import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {

  final String name;
  final String color;
  final String status;

  Profile({ 
    this.name, 
    this.color,
    this.status
     });

 // create note obj. from a firebase snapshot

  Profile.fromNoteSnapshot(DocumentSnapshot snapshot) :
   
      name= snapshot['name'],
      color= snapshot['color'],
      status = snapshot['status'];


}

