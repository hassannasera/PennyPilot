// hayda l file howi simple dart class bimasil one budget category
// A class is a blueprint: ya3ne fina na3mil kaza budget objects mino
class Budget {
  // "final" ya3ne ma fina n8ayir li bi alba sebit 3atoul
  final String category;
  // kamyit l masare li fiha  (the limit).
  final double budget;
  // Tade saraf masare fiha
  final double spent;

  // Constructor: bya3mil l object
  // The curly braces { } make the parameters "named" (we write category: ...)
  // "required" ya3ne leizm na3te value la kol w7di
  // "this.x" would also work,bas hawne hataynehoun bl list do8re
  Budget({required this.category, required this.budget, required this.spent});

  // toString() bta3mil print
  @override
  // \$ writes a real dollar sign (because $ alone is used for variables inside text).
  // $category, $spent and $budget in7ato bl value
  String toString() => '$category: \$$spent / \$$budget';
}
