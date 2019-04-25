/// Database table for the app's language
class LanguageDao {
  /// Creates an Language database table object
  LanguageDao();

  /// Language table name
  final String tableNameLanguage = 'language';

  /// Language fk id
  final String foreignColumnId = 'language_id';

  /// Language id column name
  final String columnNameId = 'id';
}
