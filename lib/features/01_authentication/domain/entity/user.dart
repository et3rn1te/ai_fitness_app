// A clean, simple User object for use within the app (UI layer).
// It's independent of any API or database.
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
}
