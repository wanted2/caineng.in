---
layout: post
title: "Pythonによるメタプログラミングーmetaclassについてー"
excerpt_separator: "<!--more-->"
categories:
  - non-english
tags:
  - メタプログラミング
  - metaprogramming
  - metaclass
  - python
  - メタクラス
toc: true
---
日々でPythonコードを書いています。
根拠なくコードを書くことが絶対良くないのです。
自信を持って根拠強いコードを書くとハイクオリティを保証できます。
メタプログラミングはPythonのクラスとメソッドの生成過程を制御できるので、その自信を確保できます。
今回はメタプログラミングのデザインパターンの中に強力なメタクラス（metaclass）について解説します。

<!--more-->
## メタプログラミングとは

プログラミングはコードでロジックを実装します。
メタプログラミングは**そのロジックをプログラミング**します。
つまり、**高次ロジックを制御する**ことになります。

例えば、シンプルな例ですが、プロジェクトの実行フェーズに入ると、各行を監視したいですね。
インスタンスが稼働する時にクラスのコードにロガーを追加することで、運用時の挙動を監視することができます。
しかし、例えば、毎回再起動時にクラスが再生成されるが、クラス生成過程も監視したい場合、クラスよりメタ段階で生成過程を定めてログ処理を記述することで、プロジェクトの監視が一貫で行えます。

## Python言語のメタプログラミングについて
Python言語では、メタプログラミングを行う道は主に2つあります。
一つ目は、ｍetaclassを利用することで、2つ目は、decoratorsを利用することです。

クラスはオブジェクトを生成するが、metaclassはクラスを生成します。
例えばｍ、下記のクラスを監視したいとしましょう。

```python
import math

class Sigmoid:
  def __init__(self):
    pass

  def preprocess(self, x):
    x = x + 1
    return x

  def postprocess(self, x):
    x = math.exp(x)
    return x / (1 + x)

  def __call__(self, x):
    x = self.preprocess(x)
    return self.postprocess(x)

sigmoid = Sigmoid()
sigmoid(-1)
# 0.5
```

このようなクラスだと、そのクラスの生成過程は隠蔽されますので、クラス生成過程を監視できません。
次に、`preprocess`と`postprocess`を抽象化して隠蔽したいです。
つまり、前処理と後処理はメタクラスで隠蔽して、動的に変更できるようにしたいです。

Python3では、クラスの定義でtypeを継承すればメタクラスを定義できます。
新クラスの生成過程を定義でき、自由に監視ロガーを追加できます。
また、前処理や後処理を属性として管理できます。
例えば、シグモイドクラスの場合、`preprocess`と`postprocess`関数を利用しますが、線形クラスの場合、`identity`関数を利用すると条件分で指定できます。

```python
import math, logging

def setup_logger(name: str, level:int=logging.DEBUG):
  """
  ロガーを設定し、インスタンスを返す。
  """
  logger = logging.getLogger(name)
  logger.setLevel(logging.DEBUG)
  ch = logging.StreamHandler()
  ch.setLevel(level)
  formatter = logging.Formatter(
      '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
  ch.setFormatter(formatter)
  logger.addHandler(ch)
  return logger

def preprocess(self, x):
  """
  前処理
  """
  x = x + 1
  return x

def postprocess(self, x):
  """
  後処理（中身はシグモイド関数）
  """
  x = math.exp(x)
  return x / (1 + x)

def identity(self, x):
  """
  線形アクティベーション関数
  """
  return x

class MetaActivation(type):
  """
  メタクラス
  """
  @classmethod
  def __prepare__(cls, name, bases, **kwargs):
    """
    新クラス生成の前処理
    クラスの種類で、前処理関数と後処理関数を動的に定める。
    """
    print(f'MetaActivation.__prepare__({cls}, {name}, {bases}, {kwargs})')
    attrs = {}
    attrs['preprocess'] = preprocess if name == 'Sigmoid' else identity
    attrs['postprocess'] = postprocess if name == 'Sigmoid' else identity
    return attrs

  def __new__(cls, name, bases, attrs, **kwargs):
    """
    ここでも属性を見直すことができます。
    今回はロガーを設定する処理を追加します。
    """
    print(f'MetaActivation.__new__({cls}, {name}, {bases}, {attrs}, {kwargs})')
    if 'logger' not in attrs:
      attrs['logger'] = setup_logger(name=name)
    return super().__new__(cls, name, bases, attrs)

  def __init__(cls, name, bases, attrs, **kwargs):
    """
    あまり意味ない設定関数です。
    通常一般クラスで__init__する。
    """
    print(f'MetaActivation.__init__({cls}, {name}, {bases}, {attrs}, {kwargs})')
    return super().__init__(name, bases, attrs)

  def __call__(cls, *args, **kwargs):
    """
    インスタンス生成時で呼び出されます。
    ここで、引数を見直すことができます。
    """
    print(f'MetaActivation.__call__({cls}, {args}, {kwargs})')
    # 引数を渡すとエラーを返す
    if len(kwargs) > 0:
      raise ValueError("The class must have no variable constructor")
    return super().__call__(*args, **kwargs)

# サンプルクラス
class Sigmoid(metaclass=MetaActivation):
  def __call__(self, x):
    self.logger.debug('Main run started with x = {}'.format(x))
    x = self.preprocess(x)
    x = self.postprocess(x)
    self.logger.debug('Main run finished with x = {}'.format(x))
    return x

class Linear(metaclass=MetaActivation):
  def __call__(self, x):
    self.logger.debug('Main run started with x = {}'.format(x))
    x = self.preprocess(x)
    x = self.postprocess(x)
    self.logger.debug('Main run finished with x = {}'.format(x))
    return x

# 実行
print("....................................................................")
sigmoid = Sigmoid() # Sigmoid(x=1)などでエラーが発生する。
print(sigmoid(-1))

print("....................................................................")
linear = Linear()
print(linear(-1))
```

出力は下記になります。
この出力からわかるように、実行だけではなくクラス生成過程も監視できます。
モニタリングとオーディティングは簡易になれます。
```text
MetaActivation.__prepare__(<class '__main__.MetaActivation'>, Sigmoid, (), {})
MetaActivation.__new__(<class '__main__.MetaActivation'>, Sigmoid, (), {'preprocess': <function preprocess at 0x000001784EC26160>, 'postprocess': <function postprocess at 0x000001784EC261F0>, '__module__': '__main__', '__qualname__': 'Sigmoid', '__call__': <function Sigmoid.__call__ at 0x000001784EC265E0>}, {})
MetaActivation.__init__(<class '__main__.Sigmoid'>, Sigmoid, (), {'preprocess': <function preprocess at 0x000001784EC26160>, 'postprocess': <function postprocess at 0x000001784EC261F0>, '__module__': '__main__', '__qualname__': 'Sigmoid', '__call__': <function Sigmoid.__call__ at 0x000001784EC265E0>, 'logger': <Logger Sigmoid (DEBUG)>}, {})
MetaActivation.__prepare__(<class '__main__.MetaActivation'>, Linear, (), {})
MetaActivation.__new__(<class '__main__.MetaActivation'>, Linear, (), {'preprocess': <function identity at 0x000001784EC26280>, 'postprocess': <function identity at 0x000001784EC26280>, '__module__': '__main__', '__qualname__': 'Linear', '__call__': <function Linear.__call__ at 0x000001784EC26670>}, {})
MetaActivation.__init__(<class '__main__.Linear'>, Linear, (), {'preprocess': <function identity at 0x000001784EC26280>, 'postprocess': <function identity at 0x000001784EC26280>, '__module__': '__main__', '__qualname__': 'Linear', '__call__': <function Linear.__call__ at 0x000001784EC26670>, 'logger': <Logger Linear (DEBUG)>}, {})
....................................................................
MetaActivation.__call__(<class '__main__.Sigmoid'>, (), {})
2021-07-04 03:23:51,474 - Sigmoid - DEBUG - Main run started with x = -1
2021-07-04 03:23:51,474 - Sigmoid - DEBUG - Main run finished with x = 0.5
0.5
....................................................................
MetaActivation.__call__(<class '__main__.Linear'>, (), {})
2021-07-04 03:23:51,476 - Linear - DEBUG - Main run started with x = -1
2021-07-04 03:23:51,476 - Linear - DEBUG - Main run finished with x = -1
-1
```

属性を自動的に追加したり管理したりすることもメタプログラミングで行えます。
例えば、ロガーやデータ準備・整理・正則化などを属性としてメタクラスで追加できます。
これにより、動的クラスや動的関数を作成できます。
運用に未知のクラスを動的に生成できるので、未知物体がある場合、静的クラスのアプローチと比べるとより柔軟な対応ができます。
## metaclassについて
上記の例の生成フローは下図に示します。
![](/assets/img/class-gen.png)

### `__prepare__`
クラス生成の最初に実行される関数です。
記述される場合、クラス生成の準備処理を行えます。
属性配列を返す関数なので、自動的に属性を追加したり管理したりすることができます。
今回の例では、前処理などを隠蔽しました。
メタプログラミングのコードを読むときに、下記のクラスだけを読むと`preprocess`や`logger`はどこに定義するか新人にとっては不思議ですが、フレームワークなどのコードではよくあるパターンであろう。

```python
class Sigmoid(metaclass=MetaActivation):
  def __call__(self, x):
    self.logger.debug('Main run started with x = {}'.format(x))
    x = self.preprocess(x)
    x = self.postprocess(x)
    self.logger.debug('Main run finished with x = {}'.format(x))
    return x
```

### `__new__`と`__init__`

### `__call__`
## 結論

