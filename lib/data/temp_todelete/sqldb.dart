import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db; //we need it to not run initialDb() in every query
  Future<Database?> get db async {
    //*Future* bcs it is asyncronous and need to wait
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  deleteDb() async {
    //OR : Future<void> deleteDb() async {
    String databasepath =
        await getDatabasesPath(); //path of the db on ur device
    String path = join(databasepath, 'Homs_ads.db'); //naming our db
    await deleteDatabase(path);

    print("======DB has been deleted=======");
  }

  initialDb() async {
    String databasepath =
        await getDatabasesPath(); //path of the db on ur device
    String path = join(databasepath, 'Homs_ads.db'); //naming our db
    Database studytoolsdb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 2,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure
    );
    //creating our db
    //version==1 means: just created, still never updated
    //when version==1: onCreate will be called (it get called only once)
    //each time the value of 'version' differs, onUpgrade is called
    return studytoolsdb;
  }
  _onConfigure(Database db)async{
    await db.execute('PRAGMA foreign_keys = ON');
  }

  _onCreate(Database db, int version) async {
    // creates db's tabels
    //this function runs only for one time
    //after that if you need to edit db architecture you will use onUpgrade
    //*this function can create only one table:
    await db.execute('''
    CREATE TABLE users (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      ar_user_name TEXT NOT NULL,
      en_user_name TEXT NOT NULL,
      email TEXT NOT NULL,
      passworrd TEXT NOT NULL,
      phone_number TEXT NOT NULL
    )
''');
    await db.execute('''
    CREATE TABLE booked (
      user_id INTEGER NOT NULL DEFAULT 0,
      ad_id INTEGER NOT NULL DEFAULT 0
    )
''');
    await db.execute('''
    CREATE TABLE ads (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      publisher_id INTEGER NOT NULL,
      num_of_book_marked INTEGER NOT NULL,
      type TEXT NOT NULL,
      FOREIGN KEY (publisher_id) REFERENCES users(id)
        ON DELETE CASCADE
    )
''');

//////////////////   cars //////////////////////
    await db.execute('''
    CREATE TABLE cars (
      ad_id INTEGER PRIMARY KEY,
      user_id INTEGER NOT NULL,
      photos TEXT NOT NULL,
      phone_numbers TEXT NOT NULL,
      for_sale INTEGER NOT NULL DEFAULT -404 CHECK (for_sale IN (0,1)),
      type_of_rent TEXT NOT NULL DEFAULT '',
      us_price INTEGER NOT NULL DEFAULT -404,
      type TEXT NOT NULL DEFAULT '',
      brand TEXT NOT NULL DEFAULT '',
      model TEXT NOT NULL DEFAULT '', 
      transmission TEXT NOT NULL DEFAULT '',
      kilometers_traveled INTEGER NOT NULL DEFAULT -404,
      year INTEGER DEFAULT -404,
      governorate TEXT NOT NULL DEFAULT '',
      address TEXT NOT NULL DEFAULT '',
      FOREIGN KEY (ad_id) REFERENCES ads(id)
        ON DELETE CASCADE
    )
''');// transmission = automatic / manual
    ///
    ///
    ///Estates:
    await db.execute('''
CREATE TABLE estates (
  ad_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  photos TEXT NOT NULL,
  phone_numbers TEXT NOT NULL,
  for_sale INTEGER NOT NULL DEFAULT -404 CHECK (for_sale IN (0,1)),
  type_of_rent TEXT NOT NULL DEFAULT '',
  us_price INTEGER NOT NULL DEFAULT -404,
  type TEXT NOT NULL DEFAULT '',
  space INTEGER NOT NULL DEFAULT -404,
  num_of_rooms INTEGER NOT NULL DEFAULT -404,
  num_of_floors INTEGER NOT NULL DEFAULT -404,
  floor_number INTEGER NOT NULL DEFAULT -404,
  clothing TEXT NOT NULL DEFAULT '',
  green_deed INTEGER NOT NULL DEFAULT -404 CHECK (green_deed IN (0,1)),
  has_wifi INTEGER NOT NULL DEFAULT -404 CHECK (has_wifi IN (0,1)),
  has_solar_panels INTEGER NOT NULL DEFAULT -404 CHECK (has_solar_panels IN (0,1)),
  governorate TEXT NOT NULL DEFAULT '',
  address TEXT NOT NULL DEFAULT '',
  description TEXT NOT NULL DEFAULT '',
  FOREIGN KEY (ad_id) REFERENCES ads(id)
    ON DELETE CASCADE
)
''');


//                           Hotels ///////////////////
  await db.execute('''
CREATE TABLE hotels (
  ad_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  photos TEXT NOT NULL DEFAULT '',
  phone_numbers TEXT NOT NULL DEFAULT '',
  hotel_name TEXT NOT NULL DEFAULT '',
  star_rating DECIMAL(2,1) NOT NULL DEFAULT -404.0,
  us_price_per_night INTEGER NOT NULL DEFAULT -404,
  has_wifi INTEGER NOT NULL DEFAULT -404 CHECK (has_wifi IN (0,1)),
  has_parking INTEGER NOT NULL DEFAULT -404 CHECK (has_parking IN (0,1)),
  has_pool INTEGER NOT NULL DEFAULT -404 CHECK (has_pool IN (0,1)),
  governorate TEXT NOT NULL DEFAULT '',
  address TEXT NOT NULL DEFAULT '',
  description TEXT NOT NULL DEFAULT '',
  FOREIGN KEY (ad_id) REFERENCES ads(id)
    ON DELETE CASCADE
)
''');

///////////////////////       restaurants and cafes
await db.execute('''
CREATE TABLE restaurants_and_cafes (
  ad_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  photos TEXT NOT NULL DEFAULT '',
  phone_numbers TEXT NOT NULL DEFAULT '',
  type TEXT NOT NULL DEFAULT 'cafe',
  name TEXT NOT NULL DEFAULT '',
  us_price INTEGER NOT NULL DEFAULT -404,
  open_hour TEXT NOT NULL DEFAULT '',
  close_hour TEXT NOT NULL DEFAULT '',
  am_or_pm_open TEXT NOT NULL DEFAULT 'am',
  am_or_pm_close TEXT NOT NULL DEFAULT 'pm',
  has_delivery INTEGER NOT NULL DEFAULT -404 CHECK (has_delivery IN (0,1)),
  has_electricity INTEGER NOT NULL DEFAULT -404 CHECK (has_electricity IN (0,1)),
  has_wifi INTEGER NOT NULL DEFAULT -404 CHECK (has_wifi IN (0,1)),
  governorate TEXT NOT NULL DEFAULT '',
  address TEXT NOT NULL DEFAULT '',
  description TEXT NOT NULL DEFAULT '',
  FOREIGN KEY (ad_id) REFERENCES ads(id)
    ON DELETE CASCADE
)
''');




    ///// add default rows:
    await db.execute('''
    INSERT INTO users 
    values (0,'افتراضي','fake user','fake.user@gmail.com','0000','0909090909')
 ''');
    await db.execute('''
    INSERT INTO users 
    values (1,'بوابة حمص','Homs Gate','homs.gate@gmail.com','0000','0911111110')
 ''');
    print("======DB has been created=======");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // await db.execute('''
    //   CREATE TABLE monitored_apps(
    //   package_name TEXT)''');
    // await db.execute('''DROP TABLE monitored_apps''');

    // await db.execute('''
    //   CREATE TABLE snaps(
    //   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    //   no_of_reviews INTEGER NOT NULL,
    //   last_review_date INTEGER NOT NULL,
    //   next_review_date INTEGER NOT NULL,
    //   type TEXT NOT NULL,
    // //   snap TEXT NOT NULL)''');

    // await db.execute("drop table mcq");
    

    await db.execute('''ALTER TABLE restaurants_and_cafes
              ADD COLUMN type TEXT NOT NULL DEFAULT 'cafe'
              ''');

    print("======DB has been upgraded=======");
  }

  select(String sql) async {
    //SELECT
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response; //returns the selected rows' data
  }

  insert(String sql) async {
    //INSERT
    Database? mydb = await db;
    int response = await mydb!.rawInsert(
      sql,
    ); //returns 0:failure  no.of.row:done
    //mydb! <--  means you are sure that it is not null
    return response;
  }

  update(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  delete(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
