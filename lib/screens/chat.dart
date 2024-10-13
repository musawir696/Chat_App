
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chat/widgets/chat_messages.dart';
import 'package:flutter_chat/widgets/new_messages.dart';

class ChatScreen extends StatefulWidget {


  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen>
{

  void setupPushNotification() async
  {


    final fcm=FirebaseMessaging.instance;
    await  fcm.requestPermission();
   // fcm.subscribeToTopic('chat');

    final token=await fcm.getToken();
    print(token);

  }

 @override

 void initSate()
 {
   super.initState();
   final fcm=FirebaseMessaging.instance;
   fcm.requestPermission();

  // setupPushNotification();
 }


  Widget build(BuildContext context) {
   return Scaffold(

     appBar:AppBar(

       title: const Text('FlutterChat'),
       actions: [
         IconButton(
           onPressed: ()
           {
             FirebaseAuth.instance.signOut();

           },
           icon: Icon(
             Icons.exit_to_app,
             color: Theme.of(context).colorScheme.primary,


           ),

         ),

       ],

     ) ,

     body:  const Column(
       children: [
        Expanded(
          child: ChatMessages(),
        ),

         NewMessage(),

       ],
     ),



     );


  }


}