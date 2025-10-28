import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pro/dataBase/Event.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/extension/date_time_extension.dart';
import 'package:pro/l10n/app_localizations.dart';
import 'package:pro/ui/common/AppFormFiled.dart';
import 'package:pro/ui/desgin/design.dart';

import '../../../dataBase/Event_Dao.dart';
import '../../../dataBase/category.dart';
import '../../common/EventInfoTile.dart';
import '../../common/Events_taps.dart';
import '../../home/ChooseLocation.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  int currentTabIndex = 0;
  List<Category> allcategoryies = Category.getCategories(incluedAll: false);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  LatLng? selectedLocation;
  String? selectedLocationName;
  Event? event;
  bool _isLoaded = false;

  var formKey = GlobalKey<FormState>();

  Category categoryModel = Category.getCategories(incluedAll: false)[0];
  int selectedCategoryIndex = 0;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isLoaded) {
      event = ModalRoute.of(context)!.settings.arguments as Event;
      titleController.text = event!.title ?? '';
      descriptionController.text = event!.description ?? '';
      selectedDate = event!.dateTime;
      selectedTime = event!.timeOfDay != null
          ? TimeOfDay.fromDateTime(event!.timeOfDay!)
          : null;

      List<Category> categories = Category.getCategories(incluedAll: false);
      selectedCategoryIndex = categories.indexWhere(
        (cat) => cat.id == event!.categoryId,
      );
      if (selectedCategoryIndex == -1) {
        selectedCategoryIndex = 0;
      }
      categoryModel = categories[selectedCategoryIndex];

      _isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    if (!_isLoaded || event == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          l10n.editEvent,
          style: context.fonts.bodyLarge?.copyWith(
            color: context.appColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset("assets/images/event_placeholder.png"),
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
                Appformfiled(
                  controller: titleController,
                  label: " Event Title",
                  icon: Icons.edit,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "please enter title";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Appformfiled(
                  controller: descriptionController,
                  label: " Description",
                  line: 5,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "please enter description";
                    }
                    return null;
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined),
                              const SizedBox(width: 8),
                              Text(
                                l10n.eventDate,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              chooseEventDate();
                            },
                            child: Text(
                              selectedDate!.formatDate,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: App_colors.light_primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined),
                              const SizedBox(width: 8),
                              Text(
                                l10n.eventTime,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              chooseEventTime();
                            },
                            child: Text(
                              selectedTime!.format(context),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: App_colors.light_primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChooseLocation(),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: EventInfoTile(
                          prefixIcon: Icons.gps_fixed_sharp,
                          suffixIcon: Icons.arrow_forward,
                          text:
                              selectedLocationName ?? l10n.updateEventLocation,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        updateEvent();
                      },
                      child: Text(l10n.updateEvent),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseEventTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void chooseEventDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  bool isValidate() {
    var invalidate = formKey.currentState?.validate() ?? false;

    if (selectedDate == null) {
      context.showMessageDialog("Please choose date");
      invalidate = false;
    } else if (selectedTime == null) {
      invalidate = false;
      context.showMessageDialog("Please choose Time");
    }
    return invalidate;
  }

  void updateEvent() async {
    if (!isValidate()) {
      return;
    }

    var updatedEventData = Event(
      id: event!.id,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate,
      timeOfDay: selectedTime?.toDateTime(),
      categoryId: allcategoryies[currentTabIndex].id,
      creatorUserId: event!.creatorUserId,
      location: selectedLocation ?? event!.location,
    );

    context.showLoadingDialog(message: "Updating Event", isDismissible: false);
    await EventDao.editEvent(updatedEventData);

    Navigator.pop(context);
    Navigator.pop(context);
  }
}
