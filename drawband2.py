# -*- coding: utf-8 -*-
# coding: utf-8
import numpy as np#导入numpy库
import matplotlib.pyplot as plt#导入matplotlib库
import pandas as pd
# plt.switch_backend('agg')
#set number
#r=input("输入y轴范围，5即-5-5：")
r=10
#title=input("输入体系名称：")
title=""
#mainpath=r"F:\yangjiong\PFpackage\drawband\Cu2In2Te4"
filename="Band"+str(title)+".png"
#导入bandstructure文件
data = pd.read_table("bandstructure.dat",header=None,sep='\s+')
da=data.values

#清理数据并截断
index=np.argwhere(np.isnan(da))#获取矩阵中空值的坐标
#print(index)
da=np.delete(da,index[:,0],0)#删除对应行

period=np.argwhere(da[:,0]==0)
#画出图像
for i in period:
    if i==0 or i==period[-1]:
        pass
    else:
        inter=int(i + period[1] - 1)
        X=da[range(int(i),inter),0]
        Y=da[range(int(i),inter),1]
        if da.shape[1]==3:
            Y2=Y=da[range(int(i),inter),2]
            plt.plot(X, Y2,'k')
        plt.plot(X,Y,'k')
plt.xlim(da[:,0].min(),da[:,0].max())
plt.ylim(int(r)*-1,int(r))

#加K-points线
kcf=pd.read_table("kcoordinates.dat",header=None,sep='\s+')
kc=kcf.values
kc[-1]=1
for i in kc:
    plt.axvline(i, color='black', linewidth=0.5, ls='--')
#加K-points标签
kstickf=pd.read_table("KPOINTS.band",header=None,sep='！')
ks=kstickf.values[4:]
ks_sep=[]
for item in ks:
    item_sep=item[0].split('!')
    ks_sep.append(item_sep)
print()
mark=[ks_sep[0][1].replace(" ","")]
for i in range(1,len(ks_sep)-1):
    if ks_sep[i] == ks_sep[i+1]:
        mark.append(ks_sep[i][1].replace(" ",""))
mark.append(ks_sep[-3][1].replace(" ","")+"/"+ks_sep[-2][1].replace(" ",""))
mark.append(ks_sep[-1][1].replace(" ",""))
print(mark)
for j in range(len(mark)):
    mark[j]='$'+mark[j]+'$'
plt.xticks(kc,mark)
plt.ylabel('$Energy$ $(eV)$', fontsize=16)
plt.title(str(title), fontsize=16)
plt.savefig(filename, bbox_inches='tight')
#plt.show()#展示图像
