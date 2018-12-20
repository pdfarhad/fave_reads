import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("_Read", [
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("title", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: true),
      SchemaColumn("author", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("year", ManagedPropertyType.integer,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false)
    ]));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final List<Map> reads = [
      {'title': 'GOF 4', 'author': 'Freeman', 'year': '1999'},
      {'title': 'Angels and Demons', 'author': 'Dan Brown', 'year': '2008'},
      {'title': 'Clean Code', 'author': 'C. Martin', 'year': '2004'}
    ];

    for (final read in reads) {
      await database.store.execute(
          'INSERT INTO _Read(title, author, year) VALUES(@title, @author, @year)',
          substitutionValues: {
            'title': read['title'],
            'author': read['author'],
            'year': read['year']
          });
    }
  }
}
