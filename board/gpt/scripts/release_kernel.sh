#!/bin/sh

cur_data=`date "+%F"`
git_dir=polaris_linux
#cur_branch=develop_v6.0
cur_branch=Polaris_release
image_path=arch/gpt/boot/vmlinux.bin
dvb_single_path="/home/10_2_1/lyy-release/$cur_branch-$cur_data/dvb-single"
dvb_multi_path="/home/10_2_1/lyy-release/$cur_branch-$cur_data/dvb-multi"
evk_single_path="/home/10_2_1/lyy-release/$cur_branch-$cur_data/evk-single"
evk_multi_path="/home/10_2_1/lyy-release/$cur_branch-$cur_data/evk-multi"

dvb_single_def=gpt_gp8300_dvb_single_defconfig
dvb_multi_def=gpt_gp8300_dvb_multi_defconfig
evk_single_def=gpt_gp8300_evk_single_defconfig
evk_multi_def=gpt_gp8300_evk_multi_defconfig

rm -rf dvb-multi dvb-single evk-multi evk-single
mkdir  dvb-single evk-multi evk-single
mkdir -p $dvb_single_path $evk_single_path $evk_multi_path

gen_dvb_single(){
git clone git@10.0.10.10:hongliang.duan/polaris_linux.git  dvb-single
cd dvb-single
git checkout $cur_branch
sh build_kernel.sh $dvb_single_def
cp -rf $image_path $dvb_single_path
cd -
}

gen_evk_single(){
git clone git@10.0.10.10:hongliang.duan/polaris_linux.git  evk-single
cd evk-single
git checkout $cur_branch
sh build_kernel.sh $evk_single_def
cp -rf $image_path $evk_single_path
cd -
}

gen_evk_multi(){
git clone git@10.0.10.10:hongliang.duan/polaris_linux.git  evk-multi
cd evk-multi
git checkout $cur_branch
sh build_kernel.sh $evk_multi_def
cp -rf $image_path $evk_multi_path
cd -
}

gen_dvb_single
gen_evk_single
gen_evk_multi

