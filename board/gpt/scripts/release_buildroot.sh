#!/bin/sh

Ver="v6.3"

#if your computer ddr size less than 8G, please delete this line.
export BR2_CCACHE_DIR="/dev/shm/"
#######################################

cur_data=`date "+%F"`
git_name=git@10.0.10.10:hongliang.duan/gpt_sw_filesystem.git
cur_branch=master
image_path=output/images/*

dvb_multi_src="dvb-multi-$cur_data"
dvb_single_src="dvb-single-$cur_data"
evk_multi_src="evk-multi-$cur_data"
evk_single_src="evk-single-$cur_data"

dvb_single_dst="/home/10_2_1/lyy-release/GP8300_SDK-$Ver-$cur_data/$dvb_single_src"
dvb_multi_dst="/home/10_2_1/lyy-release/GP8300_SDK-$Ver-$cur_data/$dvb_multi_src"
evk_single_dst="/home/10_2_1/lyy-release/GP8300_SDK-$Ver-$cur_data/$evk_single_src"
evk_multi_dst="/home/10_2_1/lyy-release/GP8300_SDK-$Ver-$cur_data/$evk_multi_src"

dvb_single_def=gpt_gp8300_dvb_mini_tools_single_defconfig
dvb_multi_def=gpt_gp8300_dvb_mini_tools_defconfig
evk_single_def=gpt_gp8300_evk_mini_tools_single_defconfig
evk_multi_def=gpt_gp8300_evk_mini_tools_defconfig

rm -rf $dvb_multi_src $dvb_single_src $evk_multi_src $evk_single_src
rm -rf $dvb_multi_dst $dvb_single_dst $evk_multi_dst $evk_single_dst

gen_dvb_single(){
	mkdir -p $dvb_single_src
	git clone $git_name  $dvb_single_src
	cd $dvb_single_src/buildroot
	git checkout $cur_branch
	sh build_gp8300.sh $dvb_single_def
	mkdir -p $dvb_single_dst
	cp -rf $image_path $dvb_single_dst
	cd -
}

gen_dvb_multi(){
	mkdir -p $dvb_multi_src
	git clone $git_name  $dvb_multi_src
	cd $dvb_multi_src/buildroot
	git checkout $cur_branch
	sh build_gp8300.sh $dvb_multi_def
	mkdir -p $dvb_multi_dst
	cp -rf $image_path $dvb_multi_dst
	cd -
}

gen_evk_single(){
	mkdir -p $evk_single_src
	git clone $git_name  $evk_single_src
	cd $evk_single_src/buildroot
	git checkout $cur_branch
	sh build_gp8300.sh $evk_single_def
	mkdir -p $evk_single_dst
	cp -rf $image_path $evk_single_dst
	cd -
}

gen_evk_multi(){
	mkdir -p $evk_multi_src
	git clone $git_name  $evk_multi_src
	cd $evk_multi_src/buildroot
	git checkout $cur_branch
	sh build_gp8300.sh $evk_multi_def
	mkdir -p $evk_multi_dst
	cp -rf $image_path $evk_multi_dst
	cd -
}

kernel_git_path=/dl/linux/git/
uboot_git_path=/dl/uboot/git/

gen_sdk_package(){

return
}

gen_dvb_multi
gen_evk_multi
gen_dvb_single
gen_evk_single

gen_sdk_package
