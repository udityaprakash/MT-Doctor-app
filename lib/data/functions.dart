
// int calculateAge(String dobString) {
//   DateTime dob = DateTime.parse(dobString);
//   DateTime now = DateTime.now();

//   int age = now.year - dob.year;

//   // Check if the birthday has occurred this year
//   if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
//     age--;
//   }

//   return age;
// }