import '../../app/controller/base_controller.dart';

class HomeListController extends BasePageController<LiveRoomItem> {
  final Site site;
  HomeListController(this.site);

  @override
  Future<List<LiveRoomItem>> getData(int page, int pageSize) async {
    var result = await site.liveSite.getRecommendRooms(page: page);

    return result.items;
  }
}