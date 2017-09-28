#!/usr/bin/perl
#
# flockを使って、スクリプトの同時実行を防ぐ(排他制御)方法のテスト。
#
# <使い方>
#  ./flock.pl >& /dev/null &
# と、一発バックグラウンドで走らせておいて、
#  ./flock.pl
# として、もう１つ起動すると、flock(LOCK,2)のほうなら１つ目が終わるまで待ち、
# flock(LOCK,6)のほうなら、dieで終わる。

#-- ロック専用の空ファイル
$lockfile = sprintf("./LOCKFILE");

open(LOCK,">$lockfile") or die "Cannot open $lockfile.\n";

#-- flockでロック
#-- ロックされていれば待つ場合
flock(LOCK,2);

#-- ロックされていれば終わる場合
#if( flock(LOCK,6) == 0 ){
#  die "This process has been locked. Stopping.\n";
#}

$n=0;
while($n<5){
  print "sleeping ($n)\n";
  sleep 1; #-- 1秒待つ
  $n++;
}

close(LOCK); #-- ロック解除
