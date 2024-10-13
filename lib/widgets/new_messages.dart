
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class NewMessage extends StatefulWidget {
  const NewMessage({super.key});


  @override
  State<NewMessage> createState() {

    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage>
{
 final _messageController=TextEditingController();

  @override
  void dispose()
  {
    _messageController.dispose();
    super.dispose();

  }

 Future<void> _submitMessage() async {
   final enteredMessage = _messageController.text;

   // Check if the message is empty
   if (enteredMessage.trim().isEmpty) {
     return;
   }

   // Dismiss the keyboard
   FocusScope.of(context).unfocus();
   // Clear the message input field
   _messageController.clear();

   // Get the current user
   final user = FirebaseAuth.instance.currentUser;

   // Ensure the user is authenticated
   if (user == null) {
     print("No user is currently signed in.");
     return; // Optionally handle this case, e.g., show a message to the user
   }

   // Fetch user data from Firestore
   final userData = await FirebaseFirestore.instance
       .collection('users')
       .doc(user.uid)
       .get();

   // Check if userData exists and has the required fields
   if (!userData.exists || userData.data() == null) {
     print("User data not found for user ID: ${user.uid}");
     return; // Optionally handle this case
   }

   // Extract the username and image URL safely
   final username = userData.data()!['username'] ?? 'Unknown User';
   final userImage = userData.data()!['image_url'] ?? '';

   // Add the message to the Firestore collection
   await FirebaseFirestore.instance.collection('chat').add({
     'text': enteredMessage,
     'createdAt': Timestamp.now(),
     'userId': user.uid,
     'username': username,
     'userImage': userImage,
   });
 }

 @override
   Widget build(BuildContext context)
  {
     return Padding(padding:const EdgeInsets.only(left: 15, right:1,bottom: 14),
       child: Row(
         children: [
           Expanded(
             child: TextField(
               controller:_messageController ,
               textCapitalization: TextCapitalization.sentences,
               autocorrect: true,
               enableSuggestions: true,
               decoration: const InputDecoration(labelText: 'Send a message...'),


             ),

           ),
           IconButton(
             color: Theme.of(context).colorScheme.primary,
             icon: const Icon(

               Icons.send,

             ),
             onPressed: _submitMessage,


           ),

         ],

       ),
     );

  }

}