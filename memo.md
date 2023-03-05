- [Flutterについて学ぶ](#flutterについて学ぶ)
  - [Flutter実践入門 - Zenn](#flutter実践入門---zenn)
    - [フォルダの基本構成](#フォルダの基本構成)
    - [画面の基本構成](#画面の基本構成)
    - [画面の更新とStateful / Stateless](#画面の更新とstateful--stateless)
    - [パッケージ](#パッケージ)
    - [アニメーション](#アニメーション)
    - [ページ遷移](#ページ遷移)
      - [Navigator](#navigator)
      - [PageView](#pageview)
    - [スマートフォンの機能の利用](#スマートフォンの機能の利用)
    - [Firebaseとの連携](#firebaseとの連携)
    - [Chapter5 : アプリのリリース](#chapter5--アプリのリリース)
    - [Chapter6 : Flutterの仕組みの活用](#chapter6--flutterの仕組みの活用)
    - [Null Safety](#null-safety)
    - [非同期処理](#非同期処理)
    - [マルチスレッド](#マルチスレッド)
    - [StatefulWidgetのライフサイクル](#statefulwidgetのライフサイクル)
    - [アプリのライフサイクル](#アプリのライフサイクル)
    - [3つのツリー](#3つのツリー)
    - [Key](#key)
    - [BuildContext](#buildcontext)
    - [InheritedWidget / Provider](#inheritedwidget--provider)
    - [ChangeNotifierProvider](#changenotifierprovider)
    - [デザインパターン](#デザインパターン)
    - [Stream](#stream)
    - [BLoC](#bloc)

---

# Flutterについて学ぶ
## [Flutter実践入門 - Zenn](https://zenn.dev/kazutxt/books/flutter_practice_introduction)
### フォルダの基本構成
各フォルダの構成は次のようになっている。
![フォルダの構成](./memo%E7%94%A8%E7%94%BB%E5%83%8F/%E3%83%95%E3%82%A9%E3%83%AB%E3%83%80%E3%81%AE%E6%A7%8B%E6%88%90.PNG)

### 画面の基本構成
Flutterでは**Widget**というパーツを組み合わせて画面を構築する。
![画面の構成](./memo%E7%94%A8%E7%94%BB%E5%83%8F/%E7%94%BB%E9%9D%A2%E3%81%AE%E6%A7%8B%E6%88%90.PNG)

それぞれのWidgetでは、「child（単一の子要素を持つ）」「children（複数の子要素を持つ）」「child / childrenなし（子要素を持たない）」のいずれかの性質を持っている。bodyのWidgetはchildしかないため、複数の子要素を与えるにはColumnなどのWidgetを間に挟む。

### 画面の更新とStateful / Stateless
変数値の変更などはプログラム上で随時行われるが、そのままでは**表示されている内容は更新されない**。**setState関数**内で変数更新を行うことで値の変更がFlutterの処理に伝わり、関係する要素を自動で更新してくれる（画面更新など）。

if文を用いて
```
if (_counter % 2 == 0)
    const Text('偶数です', style: TextStyle(fontSize: 20, color: Colors.red)),
```
のように特定の条件のときだけWidgetを表示することもできる。

**Stateful**なものとは、ある**状態**によって振る舞いが変化するようなものであり、**Stateless**なものは**状態**によらず振る舞いが一定のものである。Statefulなものは**動的**、Statelessなものは**静的**、とも表現される。

> webページで考えれば、呼び出すクライアント（＝状態）によって内容が変わる動的サイト（Stateful）と、

> 少しイメージがしにくいが、HTTPのリクエストも、同じ内容のリクエストに対しては同じレスポンスが返るため、ステートレスであると言える。

カウンタアプリでは、ボタンを押すたびにカウントが増えていくというように、カウント数という状態を持つStatefulなアプリである。状態を持つためには、StatefulなWidgetと状態を表す。

デモのアプリでは、StatefulWidgetを継承したクラス：MyHomePageとStateを継承したクラス：_MyHomePageStateが利用されている。MyHomePageの中でどんな状態を持つかという部分に_MyHomePageStateが利用されている。ロジックや状態の保持の仕方などは_MyHomePageState側で実装します。

WidgetをStatelessにする場合は、StatelessWidgetを継承したクラスをつくり、Stateと同じようにbuildメソッドでWidgetを配置する。
```
// StatelessWidget
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StatelesPage"),
      ),
      body: Text("書き換えしないページ")
     );
  }
}
```

### パッケージ
パッケージの利用は以下の2ステップ。
1. pubspec.yamlにパッケージの情報を追記する
2. ソースファイルにimportを追記する

Flutterではプロジェクトの情報と、使用するパッケージの情報を「pubspec.yaml」に記載する。
```
# 必要部分のみ抜粋/バージョンは各自の環境に合わせたものを使う
dependencies:
  flutter:
    sdk: flutter
  パッケージ名: バージョン
```

yamlにパッケージの情報を追加した後は、パッケージを利用するソースファイルでimportする。
```
// ファイルの先頭
import 追加したいパッケージ // 追加する
/* 以後プログラムを記述 */
```

### アニメーション
アニメーションを扱えるWidgetは大きく2種類に分類される。
- パラメタを設定するだけで簡単に扱えるAnimated系
- AnimationControllerとセットで利用し、駒かい制御ができるTransition系

Animated系は「AnimatedXXX」という名称のWidgetになっている。childで対象となるWidgetを指定し、アニメーションする値の開始値、終了値、変化時間（duration）を指定する。

### ページ遷移
Flutterでページ遷移を行う方法はNavigatorやPageViewを使うと実装できる。

#### Navigator
一般的なWebサイトのように「次のページへ進む」「前のページへ戻る」といったページ遷移を実現できる。これは、スタック構造のようにPushとPopをつかって実装される。
![Navigatorのページ遷移](./memo%E7%94%A8%E7%94%BB%E5%83%8F/Navigator%E3%81%AE%E3%83%9A%E3%83%BC%E3%82%B8%E9%81%B7%E7%A7%BB.PNG)

ページの遷移処理は、リンクが押された時などにNavigatorのpushで直接次のページを呼び出すか、事前にパスをつけておいてそのパスでルーティングするといった方法がある。Zennの記事の例では、StatelessWidgetの中でパスのリストを作っておき、それをルーティングのパスとしていた。

#### PageView
PageViewを使うと、PageViewの中に複数のページを内包させ、PageControllerでページ遷移を制御する。
![PageViewのページ遷移](./memo%E7%94%A8%E7%94%BB%E5%83%8F/PageView%E3%81%AE%E3%83%9A%E3%83%BC%E3%82%B8%E9%81%B7%E7%A7%BB.PNG)

### スマートフォンの機能の利用
カメラやGPSなどスマートフォンに搭載された機能を利用する場合は、そのパッケージをダウンロードしてきて利用することで実装ができる。詳細は、必要になった時に調べることにする。

### Firebaseとの連携
FirebaseはGoogleが提供しているアプリ開発のプラットフォームである。GoogleのクラウドサービスではGCPもあるが、Firebaseはこれよりもよりモバイルアプリ向けになっている。利用は従量課金制になっている。（無料枠あり）

今回の開発では、並行してバックエンド側を実装している友人が居たので、Firebaseに関する学習は別の機会に行うこととした。

### Chapter5 : アプリのリリース
リリースはもう少し先になるため、初め学習したときは流し読み。相変わらず、コマンドを少し変えるだけでビルド先替えられるの強強。FirebaseでHostingしてWebもできるので、普段のweb開発でもFlutterでUIを作るのもありかなと思った。

### Chapter6 : Flutterの仕組みの活用
### Null Safety
Null Safety：プログラム中のNullが安全に取り扱われている状態。

Flutter2ではNon-Nullable by default(NNBD)の考え方が導入されている。これは、宣言された変数にnullが入ることが認められない、というのが前提になっているという意味である。これに対して、nullを入れることができる変数（Nullable型、Null許容型）は変数宣言時の型名に```?```を付けて、```int? x```のように宣言する。

他にもnullに関する演算子としては次のようなものが用意されている。
- ```?.```演算子：変数がnullかどうかチェックしてから変数にアクセスする。変数名valueに対して```value?.length```のように使える。
- ```??```演算子：代入する変数がnullなら、右辺の値を使用する。```a = value ?? 0;```の場合、valueがnullならa = 0が代入される。
- ```??=```演算子：変数がnullなら、右辺の値が代入される。```value ??= 0;```の場合、valueがnullならvalueに0が代入される。nullでなければ0は代入されない。

### 非同期処理
非同期関数は関数に**async**というキーワードを付けて宣言する。戻り値は、一旦**Future型**を返して、遅延時間経過後にStringを返すという処理になっている。```Future<String>型```は将来的にStringが返却される型と言う意味になっている。

Future型で遅れて返されたStringは、コールバック関数を設定することで受け取ることができる。Future型には**then**というメソッドが準備されており、非同期処理が終わった時に呼び出される。

また、関数を呼び出すときに**await**のキーワードを付けると、その非同期関数が終了するまでその場で処理を待つ。すなわち、待ち合わせを行って同期的に動いている。

複数のFutuerで待ち合わせをする場合には、**Future.wait(List)**を用いて、すべての戻り値がそろうまでその場で処理を待つ。

### マルチスレッド
基本となるMainIsolateとは別のリソースを持つIsolateを作成し、並立して処理を行うことができる。お互いのIsolateはリソースが分離されているため、メッセージを送受信して情報をやり取りする。

また、スレッドを非同期関数のように扱えるComputeというものも用意されている。computeに渡された関数と引数を、別のスレッドで実行している。

### StatefulWidgetのライフサイクル
なるほど、デモアプリの```createState関数```や```build関数```、```setState関数```の意味がなんとなく分かってきた。
![StatefulWidgetのライフサイクル](./memo%E7%94%A8%E7%94%BB%E5%83%8F/StatefulWidget%E3%81%AE%E3%83%A9%E3%82%A4%E3%83%95%E3%82%B5%E3%82%A4%E3%82%AF%E3%83%AB.PNG)

### アプリのライフサイクル
別のアプリが割り込んだり、バックグラウンドに移されたりしたりといった状況を認識する。このためには、WidgetsBindingObserverクラスをMixinして利用する。このクラスのdidChangeAppLifecycleStateメソッドが、アプリの状態変化があるたびに呼び出される。

### 3つのツリー
Flutterの内部構造では、**Widgetツリー**、**Elementツリー**、**RenderObjectツリー**という3つのツリーが存在している。この3つがあることにより、表示要素の更新などのパフォーマンスを最適化している。WidgetツリーではWidgetに関するプロパティ値などを持ち、構成するオブジェクトがImmutableであるため頻繁に作り変えられる。ElementツリーではWidgetの状態や、RenderObjectのライフサイクルを管理するなど、他のツリーの仲介をおこなっている。RenderObjectツリーでは、画面のレンダリングに関する情報を持っている。

Elementツリーでは1対1に対応するWidgetの参照を持ち、StatefulWidgetの場合ElementツリーでStateObjectという状態管理用のオブジェクトをWidgetごとに持っている。setStateなどの変更イベントを行うと、StateObjectが変更されたことがElementに伝わり、Widgetが再作成される。

### Key
Elementは**Key**を使ってWidgetを識別している。Keyは明示的に設定しない場合は**null**が設定されるが、複数のオブジェクトでnullのKeyを持ってしまうと、それらは同じKeyを持つ**同じもの**だとElementに認識されてしまう。

Keyとしてどちらもnullを持つ同じ種類のWidgetでそれらを入れ替えたときを考える。Widgetツリーでのオブジェクトは入れ替えわるものの、ElementツリーからはKeyとWidgetのタイプが同じであるため、変更を検知できず再描画が行われない。
```
X 　StatefulTile(),
O　 StatefulTile(key: UniqueKey()),
```

### BuildContext
build関数の引数にもなっている**BuildContext型のcontext**はツリーの親子関係を表している。Widgetが自分の置かれている状況を認識できるように、親のElementへの参照を持つ。contextの_childを辿ることで、親Elementから子Elementの順にツリーを辿ることができる。

**ofメソッド**では、contextとは反対方向の自身の親の要素に向かって要素を辿ることができる。```style: Theme.of(context).textTheme.headline4```では、自分に設定されているThemeDataのtextTheme.headlineをStyleプロパティに設定している。

Buildメソッドのcontextからは、ofメソッドで親の要素は探せるが、子の要素を探すことはできない。そこで、Builderを用いて、要素を探す起点をツリーのさらに下へずらすという方法がある。

### InheritedWidget / Provider
**InheritedWidget**では、深くなったツリー構造においても、素早く祖先のWidgetを辿ったりツリーの再構築を制御したりすることを実現する。InheritedWidgetを使うよりも、Providerという便利なパッケージがあり、こちらを使うことが多い。利用するWidgetの上位にProviderを挟んでおき、下位のWidgetからそこへアクセスする。

### ChangeNotifierProvider
Providerの値に状態管理用のインスタンスを設定し、変更の通知と検知を行うことで、Providerを状態管理に利用できる。データが変わった時にChangeNotifierのnotifyListenersで変更を通知し、ChangeNotifierProviderが変更を検知して画面を作り直す。

### デザインパターン
デザインパターンは、アプリの設計や構造をきれいに作るためのルールである。1つの例では、アプリの機能を「Screen/UI層」「BusinessLogic層」「Repository/Resource層」に分けるものがある。各層でのデータの受け渡しや変数や変数をまとめたクラスで行う。
![デザインパターンの例](./memo%E7%94%A8%E7%94%BB%E5%83%8F/%E3%83%87%E3%82%B6%E3%82%A4%E3%83%B3%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E3%81%AE%E4%BE%8B.PNG)

### Stream
**Stream**は非同期で連続的にデータをやり取りする仕組みである。データの作成者はデータを作るたびにStreamに流し、データの利用者は定期的にStreamのデータを取得する。この両者は**非同期**に動作しても問題が無い。同一のストリームを複数から取得する場合は、broadcast streamに設定する。

### BLoC
Business Logic Componentの頭文字を取った単語で、ビジネスロジック単位で管理を行うデザインパターンである。BLoCではStreamを用いて非同期のデータのやり取りを行い、ChangeNotifierProviderではデータが変更されたときにNotifyListenersで通知をしている。