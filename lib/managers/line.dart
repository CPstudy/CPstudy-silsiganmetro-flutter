import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/foundations/config.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/values/colors.dart';
import 'package:silsiganmetro/values/constants.dart';

class Line {

  static const Map<String, dynamic> lines = {
    LINE_1: {
      'color': MColors.LINE_1,
      'title': '1호선',
    },
    LINE_2: {
      'color': MColors.LINE_2,
      'title': '2호선',
    },
    LINE_3: {
      'color': MColors.LINE_3,
      'title': "3호선",
    },
    LINE_4: {
      'color': MColors.LINE_4,
      'title': "4호선",
    },
    LINE_5: {
      'color': MColors.LINE_5,
      'title': "5호선",
    },
    LINE_6: {
      'color': MColors.LINE_6,
      'title': "6호선",
    },
    LINE_7: {
      'color': MColors.LINE_7,
      'title': "7호선",
    },
    LINE_8: {
      'color': MColors.LINE_8,
      'title': "8호선",
    },
    LINE_9: {
      'color': MColors.LINE_9,
      'title': "9호선",
    },
    GYEONGUIJUNGANG: {
      'color': MColors.GYEONGUIJUNGANG,
      'title': "경의중앙선",
    },
    AIRPORT: {
      'color': MColors.AIRPORT,
      'title': "공항철도",
    },
    GYEONGCHOON: {
      'color': MColors.GYEONGCHOON,
      'title': "경춘선",
    },
    SUIN: {
      'color': MColors.BUNDANGSUIN,
      'title': "수인선",
    },
    BUNDANG: {
      'color': MColors.BUNDANGSUIN,
      'title': "분당선",
    },
    SHINBUNDANG: {
      'color': MColors.SHINBUNDANG,
      'title': "신분당선",
    },
    UISINSEOL: {
      'color': MColors.UISINSEOL,
      'title': '우이신설선',
    }
  };

  final List<Station> list_1 = [
    Station(name: '소요산 - 구로', no: '1000000000'),
    Station(name: '소요산', no: '1001000100', up: false, nextStation: '종착역'),
    Station(name: '동두천', no: '1001000101'),
    Station(name: '보산', no: '1001000102'),
    Station(name: '동두천중앙', no: '1001000103'),
    Station(name: '지행', no: '1001000104'),
    Station(name: '덕정', no: '1001000105'),
    Station(name: '덕계', no: '1001000106'),
    Station(name: '양주', no: '1001000107'),
    Station(name: '녹양', no: '1001000108'),
    Station(name: '가능', no: '1001000109'),
    Station(name: '의정부', no: '1001000110'),
    Station(name: '회룡', no: '1001000111', type: TRANSFER),
    Station(name: '망월사', no: '1001000112'),
    Station(name: '도봉산', no: '1001000113', type: TRANSFER),
    Station(name: '도봉', no: '1001000114'),
    Station(name: '방학', no: '1001000115'),
    Station(name: '창동', no: '1001000116', type: TRANSFER),
    Station(name: '녹천', no: '1001000117'),
    Station(name: '월계', no: '1001000118'),
    Station(name: '광운대', no: '1001000119', type: TRANSFER),
    Station(name: '석계', no: '1001000120', type: TRANSFER),
    Station(name: '신이문', no: '1001000121'),
    Station(name: '외대앞', no: '1001000122'),
    Station(name: '회기', no: '1001000123', type: TRANSFER),
    Station(name: '청량리', no: '1001000124', type: TRANSFER),
    Station(name: '제기동', no: '1001000125'),
    Station(name: '신설동', no: '1001000126', type: TRANSFER),
    Station(name: '동묘앞', no: '1001000127', type: TRANSFER),
    Station(name: '동대문', no: '1001000128', type: TRANSFER),
    Station(name: '종로5가', no: '1001000129'),
    Station(name: '종로3가', no: '1001000130', type: TRANSFER),
    Station(name: '종각', no: '1001000131'),
    Station(name: '시청', no: '1001000132', type: TRANSFER),
    Station(name: '서울역', no: '1001000133', type: TRANSFER),
    Station(name: '남영', no: '1001000134'),
    Station(name: '용산', no: '1001000135', type: TRANSFER),
    Station(name: '노량진', no: '1001000136', type: TRANSFER),
    Station(name: '대방', no: '1001000137'),
    Station(name: '신길', no: '1001000138', type: TRANSFER),
    Station(name: '영등포', no: '1001000139'),
    Station(name: '신도림', no: '1001000140', type: TRANSFER),
    Station(name: '구로', no: '1001000141', type: TRANSFER, prevStation: '구일/가산디지털'),
    Station(name: '경부선(가산디지털단지 - 신창)', no: '1000000000'),
    Station(name: '가산디지털단지', no: '1001080142', type: TRANSFER, nextStation: '구로'),
    Station(name: '독산', no: '1001080143'),
    Station(name: '금천구청', no: '1001080144'),
    Station(name: '석수', no: '1001080145'),
    Station(name: '관악', no: '1001080146'),
    Station(name: '안양', no: '1001080147'),
    Station(name: '명학', no: '1001080148'),
    Station(name: '금정', no: '1001080149', type: TRANSFER),
    Station(name: '군포', no: '1001080150'),
    Station(name: '당정', no: '1001080151'),
    Station(name: '의왕', no: '1001080152'),
    Station(name: '성균관대', no: '1001080153'),
    Station(name: '화서', no: '1001080154'),
    Station(name: '수원', no: '1001080155', type: TRANSFER),
    Station(name: '세류', no: '1001080156'),
    Station(name: '병점', no: '1001080157', type: TRANSFER),
    Station(name: '세마', no: '1001080158'),
    Station(name: '오산대', no: '1001080159'),
    Station(name: '오산', no: '1001080160'),
    Station(name: '진위', no: '1001080161'),
    Station(name: '송탄', no: '1001080162'),
    Station(name: '서정리', no: '1001080163'),
    Station(name: '지제', no: '1001080164'),
    Station(name: '평택', no: '1001080165'),
    Station(name: '성환', no: '1001080166'),
    Station(name: '직산', no: '1001080167'),
    Station(name: '두정', no: '1001080168'),
    Station(name: '천안', no: '1001080169'),
    Station(name: '봉명', no: '1001080170'),
    Station(name: '쌍용', no: '1001080171'),
    Station(name: '아산', no: '1001080172'),
    Station(name: '배방', no: '1001080173'),
    Station(name: '온양온천', no: '1001080174'),
    Station(name: '신창', no: '1001080175', down: false),
    Station(name: '경인선(구일 - 인천)', no: '1000000000'),
    Station(name: '구일', no: '1001000142', nextStation: '구로'),
    Station(name: '개봉', no: '1001000143'),
    Station(name: '오류동', no: '1001000144'),
    Station(name: '온수', no: '1001000145', type: TRANSFER),
    Station(name: '역곡', no: '1001000146'),
    Station(name: '소사', no: '1001000147', type: TRANSFER),
    Station(name: '부천', no: '1001000148'),
    Station(name: '중동', no: '1001000149'),
    Station(name: '송내', no: '1001000150'),
    Station(name: '부개', no: '1001000151'),
    Station(name: '부평', no: '1001000152', type: TRANSFER),
    Station(name: '백운', no: '1001000153'),
    Station(name: '동암', no: '1001000154'),
    Station(name: '간석', no: '1001000155'),
    Station(name: '주안', no: '1001000156', type: TRANSFER),
    Station(name: '도화', no: '1001000157'),
    Station(name: '제물포', no: '1001000158'),
    Station(name: '도원', no: '1001000159'),
    Station(name: '동인천', no: '1001000160'),
    Station(name: '인천', no: '1001000161', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_2 = [
    Station(name: '본선', no: '1000000000'),
    Station(name: '성수', no: '1002000211', type: TRANSFER, nextStation: '뚝섬'),
    Station(name: '건대입구', no: '1002000212', type: TRANSFER),
    Station(name: '구의', no: '1002000213'),
    Station(name: '강변', no: '1002000214'),
    Station(name: '잠실나루', no: '1002000215'),
    Station(name: '잠실', no: '1002000216', type: TRANSFER),
    Station(name: '잠실새내', no: '1002000217'),
    Station(name: '종합운동장', no: '1002000218', type: TRANSFER),
    Station(name: '삼성', no: '1002000219'),
    Station(name: '선릉', no: '1002000220', type: TRANSFER),
    Station(name: '역삼', no: '1002000221'),
    Station(name: '강남', no: '1002000222', type: TRANSFER),
    Station(name: '교대', no: '1002000223', type: TRANSFER),
    Station(name: '서초', no: '1002000224'),
    Station(name: '방배', no: '1002000225'),
    Station(name: '사당', no: '1002000226', type: TRANSFER),
    Station(name: '낙성대', no: '1002000227'),
    Station(name: '서울대입구', no: '1002000228'),
    Station(name: '봉천', no: '1002000229'),
    Station(name: '신림', no: '1002000230'),
    Station(name: '신대방', no: '1002000231'),
    Station(name: '구로디지털단지', no: '1002000232'),
    Station(name: '대림', no: '1002000233', type: TRANSFER),
    Station(name: '신도림', no: '1002000234', type: TRANSFER),
    Station(name: '문래', no: '1002000235'),
    Station(name: '영등포구청', no: '1002000236', type: TRANSFER),
    Station(name: '당산', no: '1002000237', type: TRANSFER),
    Station(name: '합정', no: '1002000238', type: TRANSFER),
    Station(name: '홍대입구', no: '1002000239', type: TRANSFER),
    Station(name: '신촌', no: '1002000240'),
    Station(name: '이대', no: '1002000241'),
    Station(name: '아현', no: '1002000242'),
    Station(name: '충정로', no: '1002000243', type: TRANSFER),
    Station(name: '시청', no: '1002000201', type: TRANSFER),
    Station(name: '을지로입구', no: '1002000202'),
    Station(name: '을지로3가', no: '1002000203', type: TRANSFER),
    Station(name: '을지로4가', no: '1002000204', type: TRANSFER),
    Station(name: '동대문역사문화공원', no: '1002000205', type: TRANSFER),
    Station(name: '신당', no: '1002000206', type: TRANSFER),
    Station(name: '상왕십리', no: '1002000207'),
    Station(name: '왕십리', no: '1002000208', type: TRANSFER),
    Station(name: '한양대', no: '1002000209'),
    Station(name: '뚝섬', no: '1002000210'),
    Station(name: '성수', no: '1002000211', subNo: '1', type: TRANSFER, prevStation: '건대입구'),
    Station(name: '성수지선', no: '1000000000'),
    Station(name: '성수(지선)', no: '1102000211', up: false, type: TRANSFER, nextStation: '종착역'),
    Station(name: '용답', no: '1002002111'),
    Station(name: '신답', no: '1002002112'),
    Station(name: '용두', no: '1002002113'),
    Station(name: '신설동', no: '1002002114', down: false, type: TRANSFER, prevStation: '종착역'),
    Station(name: '신정지선', no: '1000000000'),
    Station(name: '신도림(지선)', no: '1102000234', up: false, type: TRANSFER, nextStation: '종착역'),
    Station(name: '도림천', no: '1002002341'),
    Station(name: '양천구청', no: '1002002342'),
    Station(name: '신정네거리', no: '1002002343'),
    Station(name: '까치산', no: '1002002344', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_3 = [
    Station(name: '대화', no: '1003000310', up: false, nextStation: '종착역'),
    Station(name: '주엽', no: '1003000311'),
    Station(name: '정발산', no: '1003000312'),
    Station(name: '마두', no: '1003000313'),
    Station(name: '백석', no: '1003000314'),
    Station(name: '대곡', no: '1003000315', type: TRANSFER),
    Station(name: '화정', no: '1003000316'),
    Station(name: '원당', no: '1003000317'),
    Station(name: '원흥', no: '1003000309'),
    Station(name: '삼송', no: '1003000318'),
    Station(name: '지축', no: '1003000319'),
    Station(name: '구파발', no: '1003000320'),
    Station(name: '연신내', no: '1003000321', type: TRANSFER),
    Station(name: '불광', no: '1003000322', type: TRANSFER),
    Station(name: '녹번', no: '1003000323'),
    Station(name: '홍제', no: '1003000324'),
    Station(name: '무악재', no: '1003000325'),
    Station(name: '독립문', no: '1003000326'),
    Station(name: '경복궁', no: '1003000327'),
    Station(name: '안국', no: '1003000328'),
    Station(name: '종로3가', no: '1003000329', type: TRANSFER),
    Station(name: '을지로3가', no: '1003000330', type: TRANSFER),
    Station(name: '충무로', no: '1003000331', type: TRANSFER),
    Station(name: '동대입구', no: '1003000332'),
    Station(name: '약수', no: '1003000333', type: TRANSFER),
    Station(name: '금호', no: '1003000334'),
    Station(name: '옥수', no: '1003000335', type: TRANSFER),
    Station(name: '압구정', no: '1003000336'),
    Station(name: '신사', no: '1003000337'),
    Station(name: '잠원', no: '1003000338'),
    Station(name: '고속터미널', no: '1003000339', type: TRANSFER),
    Station(name: '교대', no: '1003000340', type: TRANSFER),
    Station(name: '남부터미널', no: '1003000341'),
    Station(name: '양재', no: '1003000342', type: TRANSFER),
    Station(name: '매봉', no: '1003000343'),
    Station(name: '도곡', no: '1003000344', type: TRANSFER),
    Station(name: '대치', no: '1003000345'),
    Station(name: '학여울', no: '1003000346'),
    Station(name: '대청', no: '1003000347'),
    Station(name: '일원', no: '1003000348'),
    Station(name: '수서', no: '1003000349', type: TRANSFER),
    Station(name: '가락시장', no: '1003000350', type: TRANSFER),
    Station(name: '경찰병원', no: '1003000351'),
    Station(name: '오금', no: '1003000352', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_4 = [
    Station(name: '당고개', no: '1004000409', up: false, type: TRANSFER, nextStation: '종착역'),
    Station(name: '상계', no: '1004000410'),
    Station(name: '노원', no: '1004000411', type: TRANSFER),
    Station(name: '창동', no: '1004000412', type: TRANSFER),
    Station(name: '쌍문', no: '1004000413'),
    Station(name: '수유', no: '1004000414'),
    Station(name: '미아', no: '1004000415'),
    Station(name: '미아사거리', no: '1004000416'),
    Station(name: '길음', no: '1004000417'),
    Station(name: '성신여대입구', no: '1004000418', type: TRANSFER),
    Station(name: '한성대입구', no: '1004000419'),
    Station(name: '혜화', no: '1004000420'),
    Station(name: '동대문', no: '1004000421', type: TRANSFER),
    Station(name: '동대문역사문화공원', no: '1004000422', type: TRANSFER),
    Station(name: '충무로', no: '1004000423', type: TRANSFER),
    Station(name: '명동', no: '1004000424'),
    Station(name: '회현', no: '1004000425'),
    Station(name: '서울역', no: '1004000426', type: TRANSFER),
    Station(name: '숙대입구', no: '1004000427'),
    Station(name: '삼각지', no: '1004000428', type: TRANSFER),
    Station(name: '신용산', no: '1004000429'),
    Station(name: '이촌', no: '1004000430', type: TRANSFER),
    Station(name: '동작', no: '1004000431', type: TRANSFER),
    Station(name: '총신대입구(이수)', no: '1004000432', type: TRANSFER),
    Station(name: '사당', no: '1004000433', type: TRANSFER),
    Station(name: '남태령', no: '1004000434'),
    Station(name: '선바위', no: '1004000435'),
    Station(name: '경마공원', no: '1004000436'),
    Station(name: '대공원', no: '1004000437'),
    Station(name: '과천', no: '1004000438'),
    Station(name: '정부과천청사', no: '1004000439'),
    Station(name: '인덕원', no: '1004000440'),
    Station(name: '평촌', no: '1004000441'),
    Station(name: '범계', no: '1004000442'),
    Station(name: '금정', no: '1004000443', type: TRANSFER),
    Station(name: '산본', no: '1004000444'),
    Station(name: '수리산', no: '1004000445'),
    Station(name: '대야미', no: '1004000446'),
    Station(name: '반월', no: '1004000447'),
    Station(name: '상록수', no: '1004000448'),
    Station(name: '한대앞', no: '1004000449'),
    Station(name: '중앙', no: '1004000450'),
    Station(name: '고잔', no: '1004000451'),
    Station(name: '초지', no: '1004000452', type: TRANSFER),
    Station(name: '안산', no: '1004000453'),
    Station(name: '신길온천', no: '1004000454'),
    Station(name: '정왕', no: '1004000455'),
    Station(name: '오이도', no: '1004000456', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_5 = [
    Station(name: '본선', no: '1000000000'),
    Station(name: '방화', no: '1005000510', up: false, type: TRANSFER, nextStation: '종착역'),
    Station(name: '개화산', no: '1005000511'),
    Station(name: '김포공항', no: '1005000512', type: TRANSFER),
    Station(name: '송정', no: '1005000513'),
    Station(name: '마곡', no: '1005000514'),
    Station(name: '발산', no: '1005000515'),
    Station(name: '우장산', no: '1005000516'),
    Station(name: '화곡', no: '1005000517'),
    Station(name: '까치산', no: '1005000518', type: TRANSFER),
    Station(name: '신정', no: '1005000519'),
    Station(name: '목동', no: '1005000520'),
    Station(name: '오목교', no: '1005000521'),
    Station(name: '양평', no: '1005000522'),
    Station(name: '영등포구청', no: '1005000523', type: TRANSFER),
    Station(name: '영등포시장', no: '1005000524'),
    Station(name: '신길', no: '1005000525', type: TRANSFER),
    Station(name: '여의도', no: '1005000526', type: TRANSFER),
    Station(name: '여의나루', no: '1005000527'),
    Station(name: '마포', no: '1005000528'),
    Station(name: '공덕', no: '1005000529', type: TRANSFER),
    Station(name: '애오개', no: '1005000530'),
    Station(name: '충정로', no: '1005000531', type: TRANSFER),
    Station(name: '서대문', no: '1005000532'),
    Station(name: '광화문', no: '1005000533'),
    Station(name: '종로3가', no: '1005000534', type: TRANSFER),
    Station(name: '을지로4가', no: '1005000535', type: TRANSFER),
    Station(name: '동대문역사문화공원', no: '1005000536', type: TRANSFER),
    Station(name: '청구', no: '1005000537', type: TRANSFER),
    Station(name: '신금호', no: '1005000538'),
    Station(name: '행당', no: '1005000539'),
    Station(name: '왕십리', no: '1005000540', type: TRANSFER),
    Station(name: '마장', no: '1005000541'),
    Station(name: '답십리', no: '1005000542'),
    Station(name: '장한평', no: '1005000543'),
    Station(name: '군자', no: '1005000544', type: TRANSFER),
    Station(name: '아차산', no: '1005000545'),
    Station(name: '광나루', no: '1005000546'),
    Station(name: '천호', no: '1005000547', type: TRANSFER),
    Station(name: '강동', no: '1005000548', type: TRANSFER, prevStation: '길동/둔촌동'),
    Station(name: '하남 방향', no: '1000000000'),
    Station(name: '길동', no: '1005000549', nextStation: '강동'),
    Station(name: '굽은다리', no: '1005000550'),
    Station(name: '명일', no: '1005000551'),
    Station(name: '고덕', no: '1005000552'),
    Station(name: '상일동', no: '1005000553'),
    Station(name: '강일', no: '1005000554'),
    Station(name: '미사', no: '1005000555'),
    Station(name: '하남풍산', no: '1005000556'),
    Station(name: '하남시청', no: '1005000557'),
    Station(name: '하남검단산', no: '1005000558', down: false, prevStation: '종착역'),
    Station(name: '마천지선', no: '1000000000'),
    Station(name: '둔촌동', no: '1005080549', nextStation: '강동'),
    Station(name: '올림픽공원', no: '1005080550', type: TRANSFER),
    Station(name: '방이', no: '1005080551'),
    Station(name: '오금', no: '1005080552', type: TRANSFER),
    Station(name: '개롱', no: '1005080553'),
    Station(name: '거여', no: '1005080554'),
    Station(name: '마천', no: '1005080555', down: false, prevStation: '종착역'),
  ];

  final List<Station> list_6 = [
    Station(name: '응암', no: '1006000610', nextStation: '역촌', prevStation: '새절'),
    Station(name: '역촌', no: '1006000611', nextStation: '없음'),
    Station(name: '불광', no: '1006000612', type: TRANSFER, nextStation: '없음'),
    Station(name: '독바위', no: '1006000613', nextStation: '없음'),
    Station(name: '연신내', no: '1006000614', type: TRANSFER, nextStation: '없음'),
    Station(name: '구산', no: '1006000615', nextStation: '없음'),
    Station(name: '응암', no: '1006000610'),
    Station(name: '새절', no: '1006000616'),
    Station(name: '증산', no: '1006000617'),
    Station(name: '디지털미디어시티', no: '1006000618', type: TRANSFER),
    Station(name: '월드컵경기장', no: '1006000619'),
    Station(name: '마포구청', no: '1006000620'),
    Station(name: '망원', no: '1006000621'),
    Station(name: '합정', no: '1006000622', type: TRANSFER),
    Station(name: '상수', no: '1006000623'),
    Station(name: '광흥창', no: '1006000624'),
    Station(name: '대흥', no: '1006000625'),
    Station(name: '공덕', no: '1006000626', type: TRANSFER),
    Station(name: '효창공원앞', no: '1006000627', type: TRANSFER),
    Station(name: '삼각지', no: '1006000628', type: TRANSFER),
    Station(name: '녹사평', no: '1006000629'),
    Station(name: '이태원', no: '1006000630'),
    Station(name: '한강진', no: '1006000631'),
    Station(name: '버티고개', no: '1006000632'),
    Station(name: '약수', no: '1006000633', type: TRANSFER),
    Station(name: '청구', no: '1006000634', type: TRANSFER),
    Station(name: '신당', no: '1006000635', type: TRANSFER),
    Station(name: '동묘앞', no: '1006000636', type: TRANSFER),
    Station(name: '창신', no: '1006000637'),
    Station(name: '보문', no: '1006000638', type: TRANSFER),
    Station(name: '안암', no: '1006000639'),
    Station(name: '고려대', no: '1006000640'),
    Station(name: '월곡', no: '1006000641'),
    Station(name: '상월곡', no: '1006000642'),
    Station(name: '돌곶이', no: '1006000643'),
    Station(name: '석계', no: '1006000644', type: TRANSFER),
    Station(name: '태릉입구', no: '1006000645', type: TRANSFER),
    Station(name: '화랑대', no: '1006000646'),
    Station(name: '봉화산', no: '1006000647'),
    Station(name: '신내', no: '1006000648', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_7 = [
    Station(name: '장암', no: '1007000709', up: false, nextStation: '종착역'),
    Station(name: '도봉산', no: '1007000710', type: TRANSFER),
    Station(name: '수락산', no: '1007000711'),
    Station(name: '마들', no: '1007000712'),
    Station(name: '노원', no: '1007000713', type: TRANSFER),
    Station(name: '중계', no: '1007000714'),
    Station(name: '하계', no: '1007000715'),
    Station(name: '공릉', no: '1007000716'),
    Station(name: '태릉입구', no: '1007000717', type: TRANSFER),
    Station(name: '먹골', no: '1007000718'),
    Station(name: '중화', no: '1007000719'),
    Station(name: '상봉', no: '1007000720', type: TRANSFER),
    Station(name: '면목', no: '1007000721'),
    Station(name: '사가정', no: '1007000722'),
    Station(name: '용마산', no: '1007000723'),
    Station(name: '중곡', no: '1007000724'),
    Station(name: '군자', no: '1007000725', type: TRANSFER),
    Station(name: '어린이대공원', no: '1007000726'),
    Station(name: '건대입구', no: '1007000727', type: TRANSFER),
    Station(name: '뚝섬유원지', no: '1007000728'),
    Station(name: '청담', no: '1007000729'),
    Station(name: '강남구청', no: '1007000730', type: TRANSFER),
    Station(name: '학동', no: '1007000731'),
    Station(name: '논현', no: '1007000732'),
    Station(name: '반포', no: '1007000733'),
    Station(name: '고속터미널', no: '1007000734', type: TRANSFER),
    Station(name: '내방', no: '1007000735'),
    Station(name: '이수', no: '1007000736', type: TRANSFER),
    Station(name: '남성', no: '1007000737'),
    Station(name: '숭실대입구', no: '1007000738'),
    Station(name: '상도', no: '1007000739'),
    Station(name: '장승배기', no: '1007000740'),
    Station(name: '신대방삼거리', no: '1007000741'),
    Station(name: '보라매', no: '1007000742'),
    Station(name: '신풍', no: '1007000743'),
    Station(name: '대림', no: '1007000744', type: TRANSFER),
    Station(name: '남구로', no: '1007000745'),
    Station(name: '가산디지털단지', no: '1007000746', type: TRANSFER),
    Station(name: '철산', no: '1007000747'),
    Station(name: '광명사거리', no: '1007000748'),
    Station(name: '천왕', no: '1007000749'),
    Station(name: '온수', no: '1007000750', type: TRANSFER),
    Station(name: '까치울', no: '1007000751'),
    Station(name: '부천종합운동장', no: '1007000752'),
    Station(name: '춘의', no: '1007000753'),
    Station(name: '신중동', no: '1007000754'),
    Station(name: '부천시청', no: '1007000755'),
    Station(name: '상동', no: '1007000756'),
    Station(name: '삼산체육관', no: '1007000757'),
    Station(name: '굴포천', no: '1007000758'),
    Station(name: '부평구청', no: '1007000759', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_8 = [
    Station(name: '암사', no: '1008000810', up: false, nextStation: '종착역'),
    Station(name: '천호', no: '1008000811', type: TRANSFER),
    Station(name: '강동구청', no: '1008000812',),
    Station(name: '몽촌토성', no: '1008000813'),
    Station(name: '잠실', no: '1008000814', type: TRANSFER),
    Station(name: '석촌', no: '1008000815', type: TRANSFER),
    Station(name: '송파', no: '1008000816',),
    Station(name: '가락시장', no: '1008000817', type: TRANSFER),
    Station(name: '문정', no: '1008000818',),
    Station(name: '장지', no: '1008000819',),
    Station(name: '복정', no: '1008000820', type: TRANSFER),
    Station(name: '산성', no: '1008000821',),
    Station(name: '남한산성입구', no: '1008000822',),
    Station(name: '단대오거리', no: '1008000823',),
    Station(name: '신흥', no: '1008000824',),
    Station(name: '수진', no: '1008000825',),
    Station(name: '모란', no: '1008000826', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_9 = [
    Station(name: '개화', no: '1009000901', up: false, nextStation: '종착역'),
    Station(name: '김포공항', no: '1009000902', type: TRANSFER),
    Station(name: '공항시장', no: '1009000903'),
    Station(name: '신방화', no: '1009000904'),
    Station(name: '마곡나루', no: '1009000905', type: TRANSFER),
    Station(name: '양천향교', no: '1009000906'),
    Station(name: '가양', no: '1009000907'),
    Station(name: '증미', no: '1009000908'),
    Station(name: '등촌', no: '1009000909'),
    Station(name: '염창', no: '1009000910'),
    Station(name: '신목동', no: '1009000911'),
    Station(name: '선유도', no: '1009000912'),
    Station(name: '당산', no: '1009000913', type: TRANSFER),
    Station(name: '국회의사당', no: '1009000914'),
    Station(name: '여의도', no: '1009000915', type: TRANSFER),
    Station(name: '샛강', no: '1009000916'),
    Station(name: '노량진', no: '1009000917', type: TRANSFER),
    Station(name: '노들', no: '1009000918'),
    Station(name: '흑석', no: '1009000919'),
    Station(name: '동작', no: '1009000920', type: TRANSFER),
    Station(name: '구반포', no: '1009000921'),
    Station(name: '신반포', no: '1009000922'),
    Station(name: '고속터미널', no: '1009000923', type: TRANSFER),
    Station(name: '사평', no: '1009000924'),
    Station(name: '신논현', no: '1009000925'),
    Station(name: '언주', no: '1009000926'),
    Station(name: '선정릉', no: '1009000927', type: TRANSFER),
    Station(name: '삼성중앙', no: '1009000928'),
    Station(name: '봉은사', no: '1009000929'),
    Station(name: '종합운동장', no: '1009000930', type: TRANSFER),
    Station(name: '삼전', no: '1009000931'),
    Station(name: '석촌고분', no: '1009000932'),
    Station(name: '석촌', no: '1009000933', type: TRANSFER),
    Station(name: '송파나루', no: '1009000934'),
    Station(name: '한성백제', no: '1009000935'),
    Station(name: '올림픽공원', no: '1009000936', type: TRANSFER),
    Station(name: '둔촌오륜', no: '1009000937'),
    Station(name: '중앙보훈병원', no: '1009000938', down: false, prevStation: '종착역'),
  ];

  final List<Station> list_gyeonguijoongang = [
    Station(name: '문산 - 가좌', no: '1000000000'),
    Station(name: '문산', no: '1063075335', up: false, nextStation: '종착역'),
    Station(name: '파주', no: '1063075334'),
    Station(name: '월롱', no: '1063075333'),
    Station(name: '금촌', no: '1063075331'),
    Station(name: '금릉', no: '1063075330'),
    Station(name: '운정', no: '1063075329'),
    Station(name: '야당', no: '1063075999'),
    Station(name: '탄현', no: '1063075327'),
    Station(name: '일산', no: '1063075326'),
    Station(name: '풍산', no: '1063075325'),
    Station(name: '백마', no: '1063075324'),
    Station(name: '곡산', no: '1063075323'),
    Station(name: '대곡', no: '1063075322', type: TRANSFER),
    Station(name: '능곡', no: '1063075321'),
    Station(name: '행신', no: '1063075320'),
    Station(name: '강매', no: '1063075319'),
    Station(name: '화전', no: '1063075318'),
    Station(name: '수색', no: '1063075317'),
    Station(name: '디지털미디어시티', no: '1063075316', type: TRANSFER),
    Station(name: '가좌', no: '1063075315', type: TRANSFER, prevStation: '신촌/홍대입구 방면'),
    Station(name: '신촌 - 서울역', no: '1000000000'),
    Station(name: '신촌', no: '1063080312', nextStation: '가좌'),
    Station(name: '서울역', no: '1063080313', down: false, type: TRANSFER),
    Station(name: '홍대입구 - 용문', no: '1000000000'),
    Station(name: '홍대입구', no: '1063075314', type: TRANSFER, nextStation: '가좌'),
    Station(name: '서강대', no: '1063075313'),
    Station(name: '공덕', no: '1063075312', type: TRANSFER),
    Station(name: '효창공원앞', no: '1063075826', type: TRANSFER),
    Station(name: '용산', no: '1063075110', type: TRANSFER),
    Station(name: '이촌', no: '1063075111', type: TRANSFER),
    Station(name: '서빙고', no: '1063075112'),
    Station(name: '한남', no: '1063075113'),
    Station(name: '옥수', no: '1063075114', type: TRANSFER),
    Station(name: '응봉', no: '1063075115'),
    Station(name: '왕십리', no: '1063075116', type: TRANSFER),
    Station(name: '청량리', no: '1063075117', type: TRANSFER),
    Station(name: '회기', no: '1063075118', type: TRANSFER),
    Station(name: '중랑', no: '1063075119', type: TRANSFER),
    Station(name: '상봉', no: '1063075120', type: TRANSFER),
    Station(name: '망우', no: '1063075121', type: TRANSFER),
    Station(name: '양원', no: '1063075122'),
    Station(name: '구리', no: '1063075123'),
    Station(name: '도농', no: '1063075124'),
    Station(name: '양정', no: '1063075125'),
    Station(name: '덕소', no: '1063075126'),
    Station(name: '도심', no: '1063075127'),
    Station(name: '팔당', no: '1063075128'),
    Station(name: '운길산', no: '1063075129'),
    Station(name: '양수', no: '1063075130'),
    Station(name: '신원', no: '1063075131'),
    Station(name: '국수', no: '1063075132'),
    Station(name: '아신', no: '1063075133'),
    Station(name: '오빈', no: '1063075134'),
    Station(name: '양평', no: '1063075135'),
    Station(name: '원덕', no: '1063075136'),
    Station(name: '용문', no: '1063075137'),
    Station(name: '지평', no: '1063075138', down: false, prevStation: '종착역'),
  ];

  final List<Station> list_airport = [
    Station(name: '인천공항2터미널', no: '1065006511', up: false, nextStation: '종착역'),
    Station(name: '인천공항1터미널', no: '1065006510', type: TRANSFER),
    Station(name: '공항화물청사', no: '1065006509'),
    Station(name: '운서', no: '1065006508'),
    Station(name: '영종', no: '1065065072'),
    Station(name: '청라국제도시', no: '1065065071'),
    Station(name: '검암', no: '1065006507', type: TRANSFER),
    Station(name: '계양', no: '1065006506', type: TRANSFER),
    Station(name: '김포공항', no: '1065006505', type: TRANSFER),
    Station(name: '마곡나루', no: '1065065042', type: TRANSFER),
    Station(name: '디지털미디어시티', no: '1065006504', type: TRANSFER),
    Station(name: '홍대입구', no: '1065006503', type: TRANSFER),
    Station(name: '공덕', no: '1065006502', type: TRANSFER),
    Station(name: '서울역', no: '1065006501', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_gyeongchoon = [
    Station(name: '청량리', no: '1067080116', up: false, type: TRANSFER, nextStation: '종착역'),
    Station(name: '회기', no: '1067080117', type: TRANSFER),
    Station(name: '중랑', no: '1067080118', type: TRANSFER),
    Station(name: '상봉', no: '1067080120', type: TRANSFER),
    Station(name: '망우', no: '1067080121', type: TRANSFER),
    Station(name: '신내', no: '1067080122', type: TRANSFER),
    Station(name: '갈매', no: '1067080123'),
    Station(name: '별내', no: '1067080124'),
    Station(name: '퇴계원', no: '1067080125'),
    Station(name: '사릉', no: '1067080126'),
    Station(name: '금곡', no: '1067080127'),
    Station(name: '평내호평', no: '1067080128'),
    Station(name: '천마산', no: '1067080129'),
    Station(name: '마석', no: '1067080130'),
    Station(name: '대성리', no: '1067080131'),
    Station(name: '청평', no: '1067080132'),
    Station(name: '상천', no: '1067080133'),
    Station(name: '가평', no: '1067080134'),
    Station(name: '굴봉산', no: '1067080135'),
    Station(name: '백양리', no: '1067080136'),
    Station(name: '강촌', no: '1067080137'),
    Station(name: '김유정', no: '1067080138'),
    Station(name: '남춘천', no: '1067080139'),
    Station(name: '춘천', no: '1067080140', down: false, prevStation: '종착역'),
  ];

  final List<Station> list_suin = [
    Station(name: '오이도', no: '1071075250', up: false, type: TRANSFER, nextStation: '종착역'),
    Station(name: '달월', no: '1071075251'),
    Station(name: '월곶', no: '1071075252'),
    Station(name: '소래포구', no: '1071075253'),
    Station(name: '인천논현', no: '1071075254'),
    Station(name: '호구포', no: '1071075255'),
    Station(name: '남동인더스파크', no: '1071075256'),
    Station(name: '원인재', no: '1071075257', type: TRANSFER),
    Station(name: '연수', no: '1071075258'),
    Station(name: '송도', no: '1071075259'),
    Station(name: '인하대', no: '1071075260'),
    Station(name: '숭의', no: '1071075261'),
    Station(name: '신포', no: '1071075262'),
    Station(name: '인천', no: '1071075263', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_suinbundang = [
    Station(name: '청량리', no: '1075075209', up: false, type: TRANSFER, nextStation: '종착역'),
    Station(name: '왕십리', no: '1075075210', type: TRANSFER,),
    Station(name: '서울숲', no: '1075075211'),
    Station(name: '압구정로데오', no: '1075075212'),
    Station(name: '강남구청', no: '1075075213', type: TRANSFER),
    Station(name: '선정릉', no: '1075075214', type: TRANSFER),
    Station(name: '선릉', no: '1075075215', type: TRANSFER),
    Station(name: '한티', no: '1075075216'),
    Station(name: '도곡', no: '1075075217', type: TRANSFER),
    Station(name: '구룡', no: '1075075218'),
    Station(name: '개포동', no: '1075075219'),
    Station(name: '대모산입구', no: '1075075220'),
    Station(name: '수서', no: '1075075221', type: TRANSFER),
    Station(name: '복정', no: '1075075222', type: TRANSFER),
    Station(name: '가천대', no: '1075075223'),
    Station(name: '태평', no: '1075075224'),
    Station(name: '모란', no: '1075075225', type: TRANSFER),
    Station(name: '야탑', no: '1075075226'),
    Station(name: '이매', no: '1075075227', type: TRANSFER),
    Station(name: '서현', no: '1075075228'),
    Station(name: '수내', no: '1075075229'),
    Station(name: '정자', no: '1075075230', type: TRANSFER),
    Station(name: '미금', no: '1075075231', type: TRANSFER),
    Station(name: '오리', no: '1075075232'),
    Station(name: '죽전', no: '1075075233', type: TRANSFER),
    Station(name: '보정', no: '1075075234'),
    Station(name: '구성', no: '1075075235'),
    Station(name: '신갈', no: '1075075236'),
    Station(name: '기흥', no: '1075075237', type: TRANSFER),
    Station(name: '상갈', no: '1075075238'),
    Station(name: '청명', no: '1075075239'),
    Station(name: '영통', no: '1075075240'),
    Station(name: '망포', no: '1075075241'),
    Station(name: '매탄권선', no: '1075075242'),
    Station(name: '수원시청', no: '1075075243'),
    Station(name: '매교', no: '1075075244'),
    Station(name: '수원', no: '1075075255', type: TRANSFER),
    Station(name: '고색', no: '1075075245'),
    Station(name: '오목천', no: '1075075246'),
    Station(name: '어천', no: '1075075247'),
    Station(name: '야목', no: '1075075248'),
    Station(name: '사리', no: '1075075249'),
    Station(name: '한대앞', no: '1075075250', type: TRANSFER),
    Station(name: '중앙', no: '1075075251', type: TRANSFER),
    Station(name: '고잔', no: '1075075252', type: TRANSFER),
    Station(name: '초지', no: '1075075253', type: TRANSFER),
    Station(name: '안산', no: '1075075254', type: TRANSFER),
    Station(name: '신길온천', no: '1075075255', type: TRANSFER),
    Station(name: '정왕', no: '1075075256', type: TRANSFER),
    Station(name: '오이도', no: '1071075250', type: TRANSFER),
    Station(name: '달월', no: '1071075251'),
    Station(name: '월곶', no: '1071075252'),
    Station(name: '소래포구', no: '1071075253'),
    Station(name: '인천논현', no: '1071075254'),
    Station(name: '호구포', no: '1071075255'),
    Station(name: '남동인더스파크', no: '1071075256'),
    Station(name: '원인재', no: '1071075257', type: TRANSFER),
    Station(name: '연수', no: '1071075258'),
    Station(name: '송도', no: '1071075259'),
    Station(name: '인하대', no: '1071075260'),
    Station(name: '숭의', no: '1071075261'),
    Station(name: '신포', no: '1071075262'),
    Station(name: '인천', no: '1071075263', down: false, type: TRANSFER, prevStation: '종착역'),
  ];

  final List<Station> list_dxline = [
    Station(name: '강남', no: '1077000687', up: false, type: TRANSFER, nextStation: '종착역'),
    Station(name: '양재', no: '1077000688', type: TRANSFER),
    Station(name: '양재시민의숲', no: '1077000689'),
    Station(name: '청계산입구', no: '1077006810'),
    Station(name: '판교', no: '1077006811', type: TRANSFER),
    Station(name: '정자', no: '1077006812', type: TRANSFER),
    Station(name: '미금', no: '1077006813', type: TRANSFER),
    Station(name: '동천', no: '1077006814'),
    Station(name: '수지구청', no: '1077006815'),
    Station(name: '성복', no: '1077006816'),
    Station(name: '상현', no: '1077006817'),
    Station(name: '광교중앙', no: '1077006818'),
    Station(name: '광교', no: '1077006819', down: false, prevStation: '종착역'),
  ];

  final List<Station> list_uisinseol = [
    Station(name: '북한산우이', no: '1092004701', up: false, nextStation: '종착역'),
    Station(name: '솔밭공원', no: '1092004702'),
    Station(name: '4.19민주묘지', no: '1092004703'),
    Station(name: '가오리', no: '1092004704'),
    Station(name: '화계', no: '1092004705'),
    Station(name: '삼양', no: '1092004706'),
    Station(name: '삼양사거리', no: '1092004707'),
    Station(name: '솔샘', no: '1092004708'),
    Station(name: '북한산보국문', no: '1092004709'),
    Station(name: '정릉', no: '1092004710'),
    Station(name: '성신여대입구', no: '1092004711'),
    Station(name: '보문', no: '1092004712'),
    Station(name: '신설동', no: '1092004713', nextStation: '종착역'),
  ];

  List getStationsByLineString(String line) {
    switch(line) {
      case LINE_1:
        return list_1;

      case LINE_2:
        return list_2;

      case LINE_3:
        return list_3;

      case LINE_4:
        return list_4;

      case LINE_5:
        return list_5;

      case LINE_6:
        return list_6;

      case LINE_7:
        return list_7;

      case LINE_8:
        return list_8;

      case LINE_9:
        return list_9;

      case GYEONGUIJUNGANG:
        return list_gyeonguijoongang;

      case AIRPORT:
        return list_airport;

      case GYEONGCHOON:
        return list_gyeongchoon;

      case SUIN:
        return list_suin;

      case BUNDANG:
        return list_suinbundang;

      case SHINBUNDANG:
        return list_dxline;

      case UISINSEOL:
        return list_uisinseol;

      default:
        return list_2;

    }
  }
  
  List<Station> getStations(Metro metro) {
    switch(metro) {
      
      case Metro.line1:
        if(Config().line1StartGyeongbu) {
          // 경부선 먼저
          return list_1;
        } else {
          // 경인선 먼저

          const int startBu = 43;     // 경부선 시작
          const int startIn = 78;     // 경인선 시작

          List<Station> stations = List();

          for(int i = 0; i < startBu; i++) {
            stations.add(list_1[i]);
          }

          for(int i = startIn; i < list_1.length; i++) {
            stations.add(list_1[i]);
          }

          for(int i = startBu; i < startIn; i++) {
            stations.add(list_1[i]);
          }

          return stations;
        }
        break;

      case Metro.line2:
        return list_2;

      case Metro.line3:
        return list_3;

      case Metro.line4:
        return list_4;

      case Metro.line5:
        if(!Config().line5Branch) {
          // 경부선 먼저
          return list_5;
        } else {
          // 경인선 먼저

          const int startHanam = 40;       // 하남 방면 시작
          const int startMacheon = 49;     // 마천 지선 시작

          List<Station> stations = List();

          for(int i = 0; i < startHanam; i++) {
            stations.add(list_5[i]);
          }

          for(int i = startMacheon; i < list_5.length; i++) {
            stations.add(list_5[i]);
          }

          for(int i = startHanam; i < startMacheon; i++) {
            stations.add(list_5[i]);
          }

          return stations;
        }
        break;

      case Metro.line6:
        return list_6;

      case Metro.line7:
        return list_7;

      case Metro.line8:
        return list_8;

      case Metro.line9:
        return list_9;

      case Metro.gyeonguijungang:
        return list_gyeonguijoongang;

      case Metro.suinbundang:
        return list_suinbundang;

      case Metro.gyeongchun:
        return list_gyeongchoon;

      case Metro.dxline:
        return list_dxline;

      case Metro.airport:
        return list_airport;

      case Metro.uisinseol:
        return list_uisinseol;

      default:
        return null;
    }
  }
}