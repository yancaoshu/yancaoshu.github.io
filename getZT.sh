#!/bin/bash
for dir in `cat the_num_of_kl_mbj1nospin.txt | awk '{print $1}'`
do
cd $dir
cd Transportmbj_nospin/test_scan

kl=`grep $dir ../../../the_num_of_kl_mbj1nospin.txt | awk '{print $2}'`
sed '1d' RTA-trace-e.txt >RTA.txt
awk '{print $11 * 0.07}' RTA.txt >PFT
paste RTA.txt   PFT >RPFT
awk '{printf("%.8f\n",$8+'$kl')}' RPFT >kekl
paste  RPFT  kekl >temp.txt
awk '{print $12 / $13}' temp.txt >ZT
paste  ZT RPFT  >ZT.txt
sed -i -e 's/[[:space:]][[:space:]]*/ /g' ZT.txt
#ZT  emu(eV)      n(10^20/cm3)               DOS            intDOS       tau(1E-14s)         |vk|(m/s)        sigma(S/m)       ke(Wm-1K-1)      L(1E-8V2K-2)           S(uV/K)   PF(1E-4Wm-1K-2)  PF*T
done
