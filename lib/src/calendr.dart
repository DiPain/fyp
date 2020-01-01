// import 'package:fyp/pragmatic/calendar_back.dart';
// import 'package:fyp/pragmatic/each_back.dart';
// import 'package:fyp/res/decor.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class Calender extends StatelessWidget{
//   Calender(this.token);
//   final String token;
  
//   bool updated = false;
//   bool tapped = false;
//   DateTime dateToCheck = DateTime.now(); 
//   BuildContext stat_context;  
//   Widget myCalendar(BuildContext cal_context,  EventList markedDays){
//     return Container(
//       padding: EdgeInsets.only(top: 20,),
//       decoration: BoxDecor(color:Color.fromRGBO(0, 121, 255, 1)),
//       width: double.infinity,
//       height: 420,
//       child: CalendarCarousel<Event>(
//         selectedDateTime: dateToCheck,
//         markedDateIconMaxShown: 1,
//         markedDatesMap: markedDays,
//         markedDateShowIcon:true,
//         markedDateMoreShowTotal: null,
//         markedDateIconBuilder: (event){
//           return event.icon;
//         },
//         selectedDayButtonColor: (dateToCheck.compareTo(DateTime.parse( DateFormat('yyyy-MM-dd').format(DateTime.now())))==0?Colors.blue:Color.fromRGBO(0, 121, 255, 0)),
//         selectedDayTextStyle: (dateToCheck.compareTo(DateTime.parse( DateFormat('yyyy-MM-dd').format(DateTime.now())))==0?
//           (TextStyle(
//             color: Colors.white,
//           )):
//           (TextStyle(color: Colors.white))),

//         onCalendarChanged: (DateTime a){
//           final calBack = Provider.of<CalBack>(cal_context);
//           calBack.addMonth(token, a);
//         },
//         onDayPressed: (DateTime d, List<Event> events){
//           final eachBack = Provider.of<EachBack>(stat_context);
//           eachBack.perDay(token, d);
//           // StatsDialog(context,token, d);
//         },
        
//         weekendTextStyle: TextStyle(
//           color: Colors.white,
//         ),
        
//         daysTextStyle: TextStyle(
//           color: Colors.white
//         ),
//         todayButtonColor: Colors.white,
//         todayTextStyle: TextStyle(
//           color: Colors.blue
//         ),
//         weekdayTextStyle: TextStyle(
//           color: Colors.blue,
//           fontWeight: FontWeight.bold
//         ),
//         weekDayFormat: WeekdayFormat.narrow,
//         headerTextStyle: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 25,
//         ),
//         nextDaysTextStyle: TextStyle(
//           color: Colors.blue[300],
//           fontSize: 15
//         ),
//         prevDaysTextStyle: TextStyle(
//           color: Colors.blue[300],
//           fontSize: 15
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {

//     return  Scaffold(
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             ChangeNotifierProvider(
//               builder:(_)=> CalBack(),
//               child: Consumer<CalBack>(
//               builder:(context, calBack,_){
//                 final calBack = Provider.of<CalBack>(context);
//                 if(!updated){
//                   calBack.setThisMonth(token);
//                   updated = true;
//                 }
//                 return Center(child:  myCalendar(context, calBack.markedDays),);
//               }
//             ),),
            
//             // bottom half
           
//                ChangeNotifierProvider(
//                   builder:(_)=> EachBack(),
//                   child: Container(
//                       child: Consumer<EachBack>(
//                         builder:(context, eachBack,_){
//                           final eachBack = Provider.of<EachBack>(context);
//                           if(!tapped){
//                             eachBack.perDay(token, DateTime.now());
//                             tapped = true;
//                           }
//                           stat_context = context;

//                           return Expanded(
//                             child: Center(
//                               child: SingleChildScrollView(
//                                 child: Column(children: <Widget>[
//                                   Text(eachBack.tapped.toString()),
//                                   eachBack.workDay ? Roe(['work day']) :Roe(['off day']),
//                                   eachBack.hasBeep ? Roe(['beeps']):Roe(['you didnt beep this day']),
//                                   eachBack.hasBeep ? Column(children: eachBack.beepList,):SizedBox(),

//                                   SizedBox(height: 10,),
//                                   eachBack.hasEvents? Roe(['events']):Roe([]),
//                                   eachBack.hasEvents? Roe(['   ',eachBack.eventsList]):SizedBox(),
//                                   eachBack.hasBdays ? Roe(['bdays']):Roe([]),
//                                   eachBack.hasBdays ? Column(children: eachBack.bdayList,):SizedBox(),
//                                   eachBack.hasleaves ? Roe(['leave Requested']):Roe([]),
//                                   eachBack.hasleaves ? Column(children: eachBack.leaveList,):SizedBox(),
//                                 ],),
//                               ),
//                             )
//                           );
                          
//                         }
//                       ),
//                     )
//                 ),
//             Container(height: 10,
//             color: Colors.blue,),


//           ],
//         ),
//       ),
//     );
//   }
// }