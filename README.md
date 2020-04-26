# 卒業研究の実験プログラム

粒子群最適化とは実数値の最適化を行うメタヒューリスティクスの一つです。解の候補を表す複数の粒子が探索空間を動き回ることで良い解を探します。候補解集団の初期位置の決定に擬似乱数を用いるのが通常の粒子群最適化ですが、擬似乱数の代わりに擬似乱数よりも散らばった点列である超一様分布列（Halton列やSobol列）を用いて初期化を行うと散らばった初期位置を得られます。そうすると粒子群最適化の性能が良くなるのではないかと考え、擬似乱数による初期化をした粒子群最適化と超一様分布列による初期化をした粒子群最適化を比較する実験をしました。

# 機能
appendix_gbestpsoN_2.m (Octave)
  
・実験の実行と記録  
・ノンパラメトリック検定の実行

scriptmedian5_2_gp4.m (Octave)
  
・実験結果の可視化

scriptmedianthesis.m (Octave)

・実験結果から最大値、四分位数、中央値、最小値の抽出


# 必要なもの
Octaveとそのパッケージ(stk, io, statistics)

# パッケージのインストール方法

Octave上で  
```Octave
pkg install -forge stk
pkg install -forge io
pkg install -forge statistics
```

# 使い方

Octaveでスクリプトを一つずつ実行する

```Octave
appendix_gbestpsoN_2
scriptmedian5_2_gp4
scriptmedianthesis
```

# 実行例とその見方

funは関数の番号  
Dは次元  
No. of particlesは粒子の数  
FE_maxは関数評価の回数の最大値  
No. of runsは最適化の実行回数  
FITは得られた最適値の平均値（括弧内は標準偏差）    
どの関数も最小化問題で、真の最適値が0になるようにしている    

Sample1:擬似乱数で初期化した粒子群最適化の最適値No. of runs個  
Sample2:Halton列で初期化した粒子群最適化の最適値No. of runs個    
Sample3:Sobol列で初期化した粒子群最適化の最適値No. of runs個    

以上の3つのサンプルに対してノンパラメトリック検定を実行している

pvalはその検定のp値である

また、一対一の比較で差があるかも調べて出力している


```Octave
>> appendix_gbestpsoN_2
fun = 30
D = 10
No. of particles = 20
FE_max = 1000
No. of runs = 20
GBestpsoN_2
SUC = 0
EVAL = ()
FIT = 1.381723e+01(1.146596e+01)
GBestpsoN_2 - Halton Sequence
SUC = 0
EVAL = ()
FIT = 1.683197e+01(2.063896e+01)
GBestpsoN_2 - Sobol Sequence
SUC = 0
EVAL = ()
FIT = 1.079631e+01(3.348650e+00)
GBestpsoN_2
Avg. fitness = 1.381723e+01(1.146596e+01) SR = 0.000000e+00 Avg. FEs = 1.000000e+03(0.000000e+00)
Avg. time = 1.897346e-01(1.422999e-02)
GBestpsoN_2 - Halton Sequence
Avg. fitness = 1.683197e+01(2.063896e+01) SR = 0.000000e+00 Avg. FEs = 1.000000e+03(0.000000e+00)
Avg. time = 2.000721e-01(1.090831e-02)
GBestpsoN_2 - Sobol Sequence
Avg. fitness = 1.079631e+01(3.348650e+00) SR = 0.000000e+00 Avg. FEs = 1.000000e+03(0.000000e+00)
Avg. time = 3.994279e-01(2.399742e-02)
pval =  0.65051
Sample1, Sample2
y/sigma is -6.337502e-02
No significant difference

Sample1, Sample3
y/sigma is 7.695538e-01
No significant difference

Sample2, Sample3
y/sigma is 8.329289e-01
No significant difference
```