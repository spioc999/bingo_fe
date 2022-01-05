import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/services/models/bingo_paper.dart';

class SelectCardsNotifier extends BaseNotifier with ServiceMixin{
  List<BingoPaper> _bingoPapers = [];
  List<CardModel> _cards = [];
  final List<int> _selectedCards = [];

  String? _nickname;
  String? _roomCode;

  SelectCardsNotifier(BingoPaper? bingoPaper){
    if(bingoPaper != null) _bingoPapers = [bingoPaper];
  }

  init() async {
    _nickname = (await getNickname()).result;
    _roomCode = (await getRoomCode()).result;
    _convertBingoCardsToCardModels();
    notifyListeners();
  }

  void _convertBingoCardsToCardModels() {
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

  onTapNext() async{}

  String get roomCode => _roomCode ?? '';
  String get nickname => _nickname ?? '';
  List<CardModel> get cards => _cards;
  List<int> get selectedCards => _selectedCards;
}