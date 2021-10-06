

part of 'database.dart';

class $FloorAppDatabase{
  static _$AppDatabaseBuilder databaseBuilder(String name) => _$AppDatabaseBuilder(name);
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() => _$AppDatabaseBuilder(null);

}

class _$AppDatabaseBuilder {
  final String? name;
  final List<Migration> _migration = [];
  Callback? _callback;

  _$AppDatabaseBuilder(this.name);

  //
  _$AppDatabaseBuilder adMigrations(List<Migration> migrations){
    _migration.addAll(migrations);
    return this;
  }
  //
  _$AppDatabaseBuilder addCallback(Callback callback){
    _callback = callback;
    return this;
  }
  //
  Future<AppDatabase> build() async{
    final path = name != null ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migration,
      _callback
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]){
    changeListener = listener ?? StreamController.broadcast();
  }

  MealDao? _mealDaoInstance;
  Future<sqflite.Database> open(String path, List<Migration> migrations,
    [Callback? callback]) async{
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async{
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
        onOpen:(database) async{
        await callback?.onOpen?.call(database);
        },
      onUpgrade: (database, startVersion, endVersion) async{
        await MigrationAdapter.runMigrations(
            database,
            startVersion,
            endVersion,
            migrations);
        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async{
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `MealFavorites` (`id` INTEGER, `title` TEXT, `homepage` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE UNIQUE INDEX `index_MealFavorites_id` ON `MealFavorites` (`id`)');
        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }
  @override
  MealDao get mealDao {
   return _mealDaoInstance ??= _$MealDao(database, changeListener);
  }
}

class _$MealDao extends MealDao{

  final sqflite.DatabaseExecutor database;
  final StreamController<String> changeListener;
  final QueryAdapter _queryAdapter;
  final InsertionAdapter<MealFavorites> _mealFavoritesInsertionAdapter;
  final DeletionAdapter<MealFavorites> _mealFavoritesDeletionAdapter;

  _$MealDao(this.database, this.changeListener) :
      _queryAdapter = QueryAdapter(database, changeListener),
  _mealFavoritesInsertionAdapter = InsertionAdapter(
      database,
      'MealFavorites',
    (MealFavorites item) => <String, Object?>{
      'title':item.title,
    },changeListener),
  _mealFavoritesDeletionAdapter = DeletionAdapter(
      database,
      'MealFavorites',
      ['title'],
      (MealFavorites item) => <String, Object?>{
        // 'id': item.id,
        'title': item.title,
        'homepage':item..homepage,
      },
      changeListener);


  @override
  Stream<List<MealFavorites>?> findAllFavoritesStream() {
    return _queryAdapter.queryListStream('SELECT * FROM MealFavorites',
        mapper: (Map<String, Object?>row) => MealFavorites(
            row['id'] as int?,
            row['title'] as String?,
            row['homepage'] as String?),
    queryableName: 'MealFavorites',
    isView: false);
  }

  @override
  Future<void> addToFavorites(MealFavorites meal) async{
    await _mealFavoritesInsertionAdapter.insert(
      meal,
      OnConflictStrategy.abort,
    );
  }

  @override
  Future<bool?> isFavoriteById(int ids) async{
    await _queryAdapter.queryNoReturn(
        'SELECT * FROM MealFavorites WHERE ids = ?1',
        arguments: [ids]);
  }

  @override
  Future<void> removeToFavorites(MealFavorites mealFavorites) async{
    await _mealFavoritesDeletionAdapter.delete(mealFavorites);
  }

}
