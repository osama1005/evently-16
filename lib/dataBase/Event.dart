class Event {
  String? title ;
  String? desc ;
  DateTime? date ;
  String? category ;
  bool? isFav ;

  Event({required this.title,required this.desc,required this.date,
    required this.category,required this.isFav});

  String getCategoryImage() {
    switch (category) {
      case 1:
        return 'assets/images/sport.png';
      case 2:
        return 'assets/images/birthday.png';
      case 3:
        return 'assets/images/eating.png';
      case 4:
        return 'assets/images/meeting.png';
    }
    return '';
  }
}


extension dateMonth on DateTime{

  String getShortMonthName(){

    const List<String> months = [
      "Jan","Feb","Mar","Apr","May","Jun",
      "Jul","Aug","Sep","Oct","Nov","Dec"
    ];
    return months[this.month-1];
  }

}