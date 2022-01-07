import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';
import 'package:bingo_fe/services/models/bingo_paper.dart';

class SelectCardsNotifier extends BaseNotifier with ServiceMixin, RouteMixin{
  List<BingoPaper> _bingoPapers = [];
  List<CardModel> _cards = [];
  final List<int> _selectedCards = [];
  bool _hasTappedLoadMore = false;
  bool _hasTappedNext = false;

  String? _nickname;
  String? _roomCode;

  SelectCardsNotifier(BingoPaper? bingoPaper){
    if(bingoPaper != null) _bingoPapers = [bingoPaper];
  }

  init() async {
    _nickname = (await getNickname()).result;
    _roomCode = (await getRoomInfo()).result?.roomCode;
    _convertBingoCardsToCardModels();
    notifyListeners();
  }

  void _convertBingoCardsToCardModels() {
    _cards = [];
    if(_bingoPapers.isNotEmpty){
      final bingoCardsLists = _bingoPapers.map((b) => b.cards).toList();
      for (var bingoCards in bingoCardsLists){
        final cardModels = bingoCards?.map((bc) => CardModel.fromBingoCard(bc)).toList();
        if(cardModels != null){
          _cards = [..._cards, ...cardModels];
        }
      }
      notifyListeners();
    }
  }

  onTapCard(int idCard){
    if (_selectedCards.contains(idCard)){
      _selectedCards.remove(idCard);
    } else{
      _selectedCards.add(idCard);
    }
    notifyListeners();
  }

  loadNewBingoPaper() async {
    _hasTappedLoadMore = true;
    final response = await getNextBingoPaperOfRoom(
        roomCode,
        _bingoPapers.map((b) => int.parse(b.bingoPaperId ?? '')).toList()
    );
    _hasTappedLoadMore = false;

    if(response.hasError){
      showMessage(response.error!.errorMessage, messageType: MessageTypeEnum.error);
      return;
    }

    if(response.result != null){
      _bingoPapers = [..._bingoPapers, response.result!];
      _convertBingoCardsToCardModels();
    }
  }

  onTapNext() async{
    _hasTappedNext = true;
    final response = await assignCardsToUser(roomCode, nickname, selectedCards);
    _hasTappedNext = false;
    if(response.hasError){
      showMessage(response.error!.errorMessage, messageType: MessageTypeEnum.error);
      return;
    }
    navigateTo(RouteEnum.game, shouldReplace: true, arguments: _cards.where((c) => _selectedCards.contains(c.id)).toList());
  }

  String get roomCode => _roomCode ?? '';
  String get nickname => _nickname ?? '';
  List<CardModel> get cards => _cards;
  List<int> get selectedCards => _selectedCards;
  bool get loadMoreLoading => isLoading && _hasTappedLoadMore;
  bool get nextLoading => isLoading && _hasTappedNext;
}