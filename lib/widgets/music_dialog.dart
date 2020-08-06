import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/timer.dart';

class MusicDialog extends StatelessWidget {
  // final Function cancel;
  // MusicDialog();
  @override
  Widget build(BuildContext context) {
    final currentTimer = Provider.of<CurrentTimer>(context);
    // return showDialog(
    //     context: context,
    //     builder: (ctx) {
    //       AlertDialog(
    //         title: Title(
    //             color: Colors.white, child: Text("Need to think of text here")),
    //         actions: <Widget>[
    //           FlatButton(
    //               child: Text("Cancel"),
    //               onPressed: () => () {
    //                     currentTimer.setToggleDialogStatus();
    //                   })
    //         ],
    //       );
    //     });
  }
}

//  currentTimer.getShowDialogStatus() ? showDialog(
//                             context: context,
//                             builder: (ctx) {
//                               AlertDialog(
//                                 title: Title(
//                                     color: Colors.white, child: Text("Need to think of text here")),
//                                 actions: <Widget>[
//                                   FlatButton(
//                                       child: Text("Cancel"),
//                                       onPressed: () => () {
//                                             currentTimer.setToggleDialogStatus();
//                                           })
//                                 ],
//                               );
//                             }) : null