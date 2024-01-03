String formatDate(DateTime date){
  return "${date.day}/${date.month}/${date.year}";
}

String calculateAge(DateTime birthday){
  final now = DateTime.now();
  final age = now.year - birthday.year - (now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day) ? 0 : 1);
  return age.toString();
}