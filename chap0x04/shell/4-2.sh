#!/usr/bin/env bash

#统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
function age_count {
    awk -F "\t" 'BEGIN{
        young=0;middle=0;old=0;total=0;} $1!="Group"{    
        if($6<20) young++;
        else if($6<=30 && $6>=20) middle++;
        else old++;
        total = total + 1;
    }END{
        printf("age<20: %d %f%%\n",young,young*100.0/total);
        printf("20≤age≤30: %d %f%%\n",middle,middle*100.0/total);
        printf("age>30: %d %f%%\n",old,old*100.0/total);
    }' worldcupplayerinfo.tsv
}

#统计不同场上位置的球员数量、百分比
function location_count {
    awk -F "\t" '
    BEGIN{
        Goalie=0;Defender=0;Midfielder=0;Forward=0;total=0;} 
        $5!="Position"{    
        if($5=="Goalie") {Goalie++;}
        else if($5=="Midfielder"){Midfielder++;}
        else if($5=="Defender"){Defender++;}
        else if($5=="Forward"){Forward++;}
        total = total+1;
    }END{       
        printf("Goalie: %d %f%%\n",Goalie,Goalie*100.0/total);
        printf("Defender: %d %f%%\n",Defender,Defender*100.0/total);
        printf("Midfielder: %d %f%%\n",Midfielder,Midfielder*100.0/total);
        printf("Forward: %d %f\n%%",Forward,Forward*100.0/total);
    }' worldcupplayerinfo.tsv
}

#名字最长的球员是谁？名字最短的球员是谁？
function name_rank {
    awk -F "\t" '
    BEGIN{min=10000;max=0} 
        $1!="Group"{
        l=length($9);
        name[$9]=l;
        max=l>max?l:max;
        min=l<min?l:min;
    }END{
        for(i in name) {
                if(name[i]==max) printf("The longest name is %s\n", i);
                if(name[i]==min) printf("The shortest name is %s\n", i);               
    }
    }' worldcupplayerinfo.tsv
}

#年龄最大的球员是谁？年龄最小的球员是谁？
function age_rank {
    awk -F "\t" 'BEGIN{
        min=10000;max=0} $1!="Group"{
        name[$9]=$6;
        if($6>max) max=$6;
        if($6<min) min=$6;
    }END{
        for(i in name) {
                if(name[i]==max) printf("The oldest man is %s,his old is %d\n", i ,name[i]);
                if(name[i]==min) printf("The youngest man is %s,his old is %d\n",i ,name[i]);               
    }
    }' worldcupplayerinfo.tsv
}

function help {
    echo "-a                 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比"
    echo "-l                 统计不同场上位置的球员数量、百分比"
    echo "-n                 名字最长的球员是谁？名字最短的球员是谁？"
    echo "-y                 年龄最大的球员是谁？年龄最小的球员是谁？"
    echo "-h                 帮助文档"
}

if [ "$1" != "" ];then #判断是什么操作
    case "$1" in
        "-a")
            age_count
            exit 0
            ;;
        "-l")
            location_count
            exit 0
            ;;    
        "-n")
            name_rank
            exit 0
            ;;
        "-y")
            age_rank
            exit 0
            ;;
        "-h")
            help
            exit 0
            ;;
    esac
fi