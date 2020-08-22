

import 'package:flutter/material.dart';

enum Priority { High, Low, Medium }

String getPriorityString(Priority priority) {
    if (priority == Priority.Low) {
        return "Low"; 
    }
    if (priority == Priority.Medium) {
        return "Medium";  
    }
        return "High";  
  }     

Priority getPriorityEnum(String priority){
  if (priority =="Low" || priority == '') {
        return Priority.Low; 
    }
    if (priority == "Medium") {
        return Priority.Medium;  
    }
        return Priority.High;  
}

Color getPriorityColor(Priority priority) {
    if (priority == Priority.Low) {
      return Colors.green;
    }
    if (priority == Priority.Medium) {
      return Colors.yellow[900];
    }
    return Colors.red[900];
  }