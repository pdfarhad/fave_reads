import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:fave_reads/fave_reads.dart';
import '../model/read.dart';

class ReadsController extends ResourceController {
  ReadsController(this.context);

  ManagedContext context;

  @Operation.get()
  Future<Response> getAllReads() async {
    final readQuery = Query<Read>(context);
    return Response.ok(await readQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getRead(@Bind.path('id') int id) async {
    final readQuery = Query<Read>(context)
      ..where((read) => read.id).equalTo(id);

    final read = await readQuery.fetchOne();

    if (read == null) {
      return Response.notFound(body: 'Item not found!');
    }

    return Response.ok(read);
  }

  @Operation.post()
  Future<Response> createnewRecord(@Bind.body() Read body) async {
    final readQuery = Query<Read>(context)..values = body;

    final insertToRead = await readQuery.insert();

    return Response.ok(insertToRead);
  }

  @Operation.put('id')
  Future<Response> updateRead(
      @Bind.path('id') int id, @Bind.body() Read body) async {
    final readQuery = Query<Read>(context)
      ..values = body
      ..where((read) => read.id).equalTo(id);

    final updateQuery = await readQuery.updateOne();

    if (updateQuery == null) {
      return Response.notFound(body: "Item Not Found!");
    }

    return Response.ok(updateQuery);
  }

  @Operation.delete('id')
  Future<Response> deleteRead(@Bind.path('id') int id) async {
    final readQuery = Query<Read>(context)
      ..where((read) => read.id).equalTo(id);

    final int deleteCount = await readQuery.delete();
    if (deleteCount == 0) {
      return Response.notFound(body: "Item Not Found!");
    }

    return Response.ok('Deleted $deleteCount item.');
  }
}
