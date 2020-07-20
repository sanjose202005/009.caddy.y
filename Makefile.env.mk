
xcaddy=$(GoPath21)/xcaddy
go_build_env = CGO_ENABLED=0 $(GoPreLinux386)

CFGmakeRun:=Makefile.run.go01.mk

GoTOP:=\
	test01

X:=commit_all
$(X):=ga gcX up
X $(X): $($(X))

gclient:=$(PWD)/depot_tools/gclient
fetch:=$(PWD)/depot_tools/fetch

    
n05:=clone_and_build_naiverproxy
n05 $(n05):
	nice -n 19 make n05X

target_cpu:=arm64
export target_cpu

n05X:
	[ -d naiveProxy/ ] || git clone           --depth 1 https://github.com/klzgrad/naiveproxy.git    naiveProxy/ 
	[ -d naiveProxy/ ]
	for aa1 in src/build.sh .gclient .gclient_entries ; do \
		test -f naiveProxy.arm.conf/$${aa1} && \
		echo cp naiveProxy.arm.conf/$${aa1} naiveProxy/$${aa1} ; \
		cp      naiveProxy.arm.conf/$${aa1} naiveProxy/$${aa1} ; \
		done ; echo -n
	rm -f      naiveProxy/src/out/Release/naive*
	#
	cd naiveProxy/src && ( export target_cpu=$(target_cpu) ; ./get-clang.sh )
	#cd naiveProxy/src && ( export target_cpu=$(target_cpu) ; ./build.sh     )
	#cd naiveProxy/src && ./get-clang.sh 
	#
	#cd naiveProxy/src && echo "target_os = [ 'android' ]" > ../.gclient
	#cd naiveProxy/src && $(gclient) sync
	#
	#cd naiveProxy/src && ./build.sh     
	#cd naiveProxy/src && ( export target_cpu=$(target_cpu) ;export EXTRA_FLAGS='target_cpu="$(target_cpu)"' ; ./build.sh     )
	cd naiveProxy/src && ( \
		export target_cpu=$(target_cpu) ; \
		export EXTRA_FLAGS=$$'\ntarget_os="android"\ntarget_cpu="$(target_cpu)"' \
		; ./build.sh     )
	#
	llvm-strip -o \
		naiveProxy/src/out/Release/naive.build.strip.bin \
		naiveProxy/src/out/Release/naive      
	mkdir -p bin/
	cp         naiveProxy/src/out/Release/naive.build.strip.bin bin/
	test -f   bin/naive.run.server.sh || \
		echo -e "#/bin/bash\n\nnice -n 19 ./naive.build.strip.bin  naive.config.json.200.server.127.0.0.1.41080.json \n" \
		>     bin/naive.run.server.sh
	chmod 755 bin/naive.run.server.sh
	md5sum              naiveProxy/src/out/Release/naive*
	ls  -l              naiveProxy/src/out/Release/naive*
	@echo
	@echo sudo setcap cap_net_bind_service=+ep naiveProxy/src/out/Release/naive*
	@echo
#https://github.com/klzgrad/naiveproxy/releases/download/v83.0.4103.61-1/naiveproxy-v83.0.4103.61-1-linux-x64.tar.xz


n06 $(n06):
	nice -n 19 make n06x
n06x:
	git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

n07 $(n07):
	nice -n 19 make n07x
n07x:
	[ -d chromium ] || mkdir chromium 
	cd   chromium && $(fetch) --nohooks android



showRunHelpListLast += n06 n07 n05 X

.PHONY : x1 x2 c1 conf
