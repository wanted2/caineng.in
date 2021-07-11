---
layout: post
title: "Pythonによるメタプログラミングーデコレーター・パターンについてー"
excerpt_separator: "<!--more-->"
categories:
  - pm
  - non-english
tags:
  - メタプログラミング
  - metaprogramming
  - decorator
  - python
  - デコレーター・パターン
toc: true
---
![](https://refactoring.guru/images/patterns/content/decorator/decorator-2x.png?id=736ab07b1d8920ab2c7a)
_Source: https://refactoring.guru_

関数を実行するときに、実行時間とリソース管理を監視し、レポートすることは不可欠です。
さらに、異常や例外が検知された時に、実行を制御できるとなお嬉しくなります。
例えば、途中経過時間が長くなると、スレッド数を増やし、実行時間を短縮させるとか、リソースが足りないとか、コミュニケーションがうまくいかないなどの不具合が発生するときの対応を行う方法が必要となります。
単に、関数毎に処理を記述すると、制御を組織のすべての関数に正則化できないといった問題があるため、メタプログラミングで制御の論理をすべての関数で対応できます。
前回で紹介したメタクラス [1]について、クラスの初期化で一つのパターンを記述すると、実行時に条件に応じて複数のパターンのクラスを生成できますが、今回で実行時の制御処理にもひとつのメタパターンを紹介します。
それ**デコレーターパターン** [2]です。

<!--more-->

# デコレーター・パターン

単に　**「関数を戻り値として返す関数」**と解釈すれば良いですが、具体的にPython言語でみてみます。
ある関数fを実行する時に、関数の中身に記述せずに監視や認証・制御などの別の処理を行ってから関数fを実行するようなパターンです。


```python
import numpy as np

def f(x):
  y = x + 1
  return y
```

この関数の実行時間を測定したい場合、下記に2案あります。

```python
import time

def f(x):
  y = x + 1
  return y

# 案1：関数の中身を変更し、実行時間を測定するロジックを記述
def f2(x):
  start = time.time()
  y = x + 1
  end = time.time()
  print(f"実行時間：{end-start:.5f}秒")
  return y

# 案2：デコレーター・パターンを利用
def measure_time(f):
  def wrapper(*args):
    start = time.time()
    y = f(*args)
    end = time.time()
    print(f"実行時間：{end-start:.5f}秒")
    return y
  return wrapper

@measure_time
def f3(x):
  y = x + 1
  return y

# 下記の3パターンは同じ結果になります。
f2(1) # 内部を変えてしまう
measure_time(f)(1) # デコレーターを展開すると同等の記述
f3(1) # pythonのデコレーター
```

上記の案1だと、外部要件に対して内部組織を変えてしまう感じですね。
悪くもないけれども、毎回毎関数をこんなに内部変更を行ういくつかの問題が発生します。

* **品質の低下**。修正工夫が大きくなり、コードが「スパゲッティ」になりうる。
* **コード管理が難しくなります**。実行関数に外部による微細修正が加えたので、問題発生時、毎関数を見ないといけない。
* **スコープ管理が緩和された**。外部要件によって変更しやすいので、スコープも良く変わってしまう。
* **内部修正は危険**。プロジェクト内に関数は1つの場所に使用されない場合、その関数を内部修正するとほかの場所にも影響を与えてしまう。

# 事例

```python
import numpy as np

def solve(A, x, b):
  return A * x + b

def solve_double(A, x, b):
  y = solve(A, x, b)
  return solve(A, y, b)
```

監視と制御を行うと、

* `solve_double`の各ステップの実行時間を計測したいです。ベンチマークや監視に使われます。
* `y`の実行時間が長くなると、`solve(A, y, b)`の実行時間を短縮できるように制御したいです。

といった単純な関数実行の制御の要件を実現したいです。

```python
import time
import numpy as np
from typing import Any

class Controller:
  reports = []

  def __init__(self, action_trigger_threshold:float=0.4) -> None:
    self.action_trigger_threshold = action_trigger_threshold

  def receive_report(self, t: float) -> None:
    self.reports.append(t)

  def is_slow(self) -> bool:
    return len(self.reports) > 0 and \
      self.reports[-1] >= self.action_trigger_threshold

# コントローラー記述
project_controller = Controller(action_trigger_threshold=0.0005)

class Decorator: 

  @staticmethod
  def on_slow() -> Any:
    """
    遅いタスクが発見された場合、制御するデコレーターパターン。
    """
    def decorator(f):
        def wrapper(*args):
            if project_controller.is_slow():
                print("遅い実行が発見。次の実行をよくするためにポストコントロールしてください。")
                # 高速化するために工夫を記述する
                # 入力のサイズを縮小するか、環境変数を調整するか、スレッド数を増えるか
                pass
            return f(*args)
        return wrapper
    return decorator
 
  @staticmethod
  def measure_time() -> Any:
    def decorator(f):
        def wrapper(*args: object):
            # 実行時間を測定
            start = time.time()
            result = f(*args)
            end = time.time()
            # ログを残す
            print(f'実行時間は{end-start:.5f}秒です。')
            # 制御インスタンスに実行時間をレポートする
            project_controller.receive_report(end-start)
            return result
        return wrapper
    return decorator

# デコレーターパターンを追加
@Decorator.measure_time()
@Decorator.on_slow()
def solve(A, x, b):
  return A * x + b

def solve_double(A, x, b):
  y = solve(A, x, b)
  return solve(A, y, b)


A = np.eye(1000, 1000)
x = np.ones((1000,1))
b = np.ones((1000,1))

solve_double(A, x, b)
print(project_controller.reports)
```

実行結果はこんなになります。

```bash
$ python decorator.py
実行時間は0.00900秒です。
遅い実行が発見。次の実行をよくするためにポストコントロールしてください。
実行時間は0.00900秒です。
[0.008999109268188477, 0.009003400802612305]
```


## 複数デコレーター

上記のコードには下記のデコレーターパターンを利用しています。


```python
@Decorator.measure_time()
@Decorator.on_slow()
```

実行順序は下記になります。

1. プロジェクトコントローラー`project_controller`に問い合わせ`is_slow`で実行歴には、最終実行で遅くなったことがあるか確認する。遅くなった場合、ログも残し、プロジェクトの内容に応じてそれぞれの制御を行う。
2. 実行時間を測定し、ログを残し、プロジェクトコントローラー`project_controller`に実行記録を更新する。
3. `solve`本体を実行する。

## プロジェクト・コントローラー

`project_controller`の重要性は、プロジェクトによって変わるけど、今回の要件では、重要だと仮定しましょう。
その制御変数は、実行時間をキープしたり遅いプロセスを発見したりしますので関数を監視するために役立つ情報を管理しています。

# 課題

よく使うと良い武器になるが、悪く使うと制御できない武器になりえます。
メタプログラミングは勢いため、悪用はもちろんあります。

```python
def plus_one(f):
  def wrapper(*args):
    return f(*args) + 1
  return wrapper

@plus_one
def identity(x):
  return x

# 別のファイルで
identity(1)
# 出力
# 2
```

`identity`を呼ぶのに1を足した結果になります。
出力、あるいは、レスポンスを変えてしまう利用になりますので、スコープが変更されてしまうという課題です。

コードを難読化するために、利用すると良い場面もあります。
ですが、実用であまりこの「出力を変更してしまうパターン」を利用しない方がいいかもしれません。

# 結論

勢いパターンであるデコレーター・パターンを紹介しました。
実行時の制御や監視などに役に立します。
内部変更を防ぎ、スコープ管理やコード管理をよくするパターンです。
しかし、出力を変更してしまう場合、気をつけて利用しましょう。
Pythonのフレームワークにはこのパターンはよく使われます。
DjangoやFlaskのフレームワーク・コードをよく見ると必ず出会うパターンですので、悪用せずによく利用するとメリットばかりです。

# 参考文献

{% bibliography --file meta %}