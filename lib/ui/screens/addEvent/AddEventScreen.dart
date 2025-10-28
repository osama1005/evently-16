import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pro/dataBase/Event.dart';
import 'package:pro/dataBase/Event_Dao.dart';
import 'package:pro/dataBase/category.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/extension/date_time_extension.dart';
import 'package:pro/ui/common/AppFormFiled.dart';
import 'package:pro/ui/common/Events_taps.dart';
import 'package:pro/ui/providers/AppAuthprovider.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../common/EventInfoTile.dart';
import '../../home/ChooseLocation.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int currentTabIndex = 0;
  List<Category> allcategoryies = Category.getCategories(incluedAll: false);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LatLng? selectedLocation;
  String? selectedLocationName;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                          image: allcategoryies[currentTabIndex].title!.isNotEmpty
                              ? AssetImage(
                            "assets/icons/${allcategoryies[currentTabIndex].title}.png",
                          )
                              : const AssetImage("assets/icons/default.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      EventsTaps(allcategoryies, reversed: true, currentTabIndex, (
                          index,
                          category,
                          ) {
                        setState(() {
                          currentTabIndex = index;
                        });
                      }),
                      const SizedBox(height: 16),
                      Appformfiled(
                        controller: titleController,
                        label: " Event Title",icon: Icons.edit,
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return "please enter title";
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Appformfiled(
                        controller: descriptionController,
                        label: " Description",line:5,
                        validator: (text){
                          if(text == null || text.isEmpty){
                            return "please enter description";
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range_outlined),
                              Text(" Event date ",
                                style:context.fonts.bodyMedium?.copyWith(
                                  color: Colors.black,
                                ) ,),
                            ],
                          ),
                          TextButton(
                            onPressed: (){
                              chooseDate();
                            },
                            child: Text( selectedDate == null ? " Choose Date"
                                : selectedDate?.format() ?? "",
                              style:context.fonts.bodyMedium?.copyWith(
                                color: context.appColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.timer),
                              Text(" Event Time ",
                                style:context.fonts.bodyMedium?.copyWith(
                                  color: Colors.black,
                                ) ,),
                            ],
                          ),
                          TextButton(
                            onPressed: (){
                              chooseTime();
                            },
                            child: Text(
                              selectedTime == null ? " Choose Time" :
                              selectedTime?.format(context) ?? "",
                              style:context.fonts.bodyMedium?.copyWith(
                                color: context.appColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseLocation(),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              selectedLocation = result['latLng'];
                              selectedLocationName = result['address'];
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: EventInfoTile(
                            prefixIcon: Icons.gps_fixed_sharp,
                            suffixIcon: Icons.arrow_forward,
                            text: selectedLocationName == null
                                ? l10n.chooseLocation
                                : selectedLocationName ?? '',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                    ],
                  ),
                ),
              ),

              ElevatedButton(onPressed: (){
                createEvent();
              }, child: Text("Add Event "))
            ],
          ),
        ),
      ),
    );
  }

  void chooseDate()async {
    var date = await  showDatePicker(context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 60))
    );
    setState(() {
      selectedDate = date ;
    });
  }

  void chooseTime()async {
    var time = await showTimePicker(context: context,
        initialTime: TimeOfDay.now()
    );
    setState(() {
      selectedTime = time ;
    });
  }

  bool isvalidate(){
    var isValid = formKey.currentState?.validate() ?? false ;
    if(selectedDate == null){
      context.showMessageDialog("please choose date");
      isValid = false ;
    }
    else if(selectedTime == null){
      context.showMessageDialog("please choose Time");
      isValid = false ;
    }
    return isValid ;
  }

  void createEvent()async {
    if(!isvalidate()){
      return ;
    }
    var authProvider = Provider.of<AppAuthProvider>(context,listen: false);
    var event = Event(
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate,
      timeOfDay: selectedTime?.toDateTime(),
      location: selectedLocation,
      creatorUserId:authProvider.getUser()?.id,
      categoryId: allcategoryies[currentTabIndex].id,
    );
    context.showLoadingDialog(message: "event created successfully",isDismissible: false);
    await EventDao.addEvent(event);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}