#!/bin/bash
#BSUB -q cren
#BSUB -o out%J.txt
#BSUB -e error%J.txt
#BSUB -J 1
#BSUB -n 24
#BSUB -R "span[hosts=1]"
source /share/apps/intel/ipsxe2017/parallel_studio_xe_2017.0.035/psxevars.sh >/dev/null 2>&1
for dir in `cat the_num_of_df_mbj1nospin.txt | awk '{print $1}' `
#for dir in Ba1O3Zr1
do
cd $dir
cd Transportmbj_nospin/test_scan
rm TAU
rm RTA-t*
rm CRTA-t*
getgap
edef=`grep $dir ../../../the_num_of_df_mbj1nospin.txt | awk '{print $2}'`
Y=`awk '{print $3}' ../../Elastic/cij2kL.txt | tail -n 1`

gap=`cat gap.txt | tail -1 | awk '{print $4}'`
Nel=`grep NELE OUTCAR | awk '{print $3}'`
CBB=`grep CBM gap.txt | awk '{print $13}'`   ###############added by xinli,20170606
Efer=`grep E-fermi OUTCAR | awk '{print $3}'`
vol=`grep vol OUTCAR | tail -1 | awk '{print $5}'`
carr[1]=0.01;carr[2]=100;carr[3]=-100;carr[4]=-0.01  ######the carrier concentration is between E18~E22
        for ((i=1;i<=4;i++))
        do
        netotal[$i]=`echo "$vol*${carr[$i]}*0.0001+$Nel" | bc -l`   #######total electronic state of different carrier concentration
        echo "T" >temp
        if (($lenth>0))
        then
        echo "  "$CBB"  " >> temp
        echo "-0.5" >> temp
        else
        echo "  "$CBB"  "$CBB >> temp
        echo "-0.5  -0.5" >>temp
        fi
        echo ${netotal[$i]}>>temp
        echo "700" >>temp
        Ecarr[$i]=`efdetermin < temp | tail -1 | awk '{print $2}'`   #######Energy of different carrier concentration
        dECARR[$i]=`echo "(${Ecarr[$i]})-($Efer)" | bc -l`  ##### Ecarr-Efermi
        done
NE=`echo "((${Ecarr[2]})-(${Ecarr[1]}))/0.001+1" | bc -l | awk -F "." '{print $1}'`
echo $Efer ${dECARR[1]} 0.001 $NE 700 $CBB -0.5 $Nel >finale.input  ##############changed by xinli,20170606
rm TAU
echo "$edef" "$Y" "0.5" >>finale.input
transoptic_e
cd ../../../
done
