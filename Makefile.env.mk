
xcaddy=$(GoPath21)/xcaddy
go_build_env = CGO_ENABLED=0 $(GoPreLinux386)

CFGmakeRun:=Makefile.run.go01.mk

GoTOP:=\
	test01
    
n05:=clone_and_build_naiverproxy
n05 $(n05):
	[ -d naiveProxy/ ] || git clone           --depth 1 https://github.com/klzgrad/naiveproxy.git    naiveProxy/ 
	[ -d naiveProxy/ ]
	rm -f      naiveProxy/src/out/Release/naive*
	cd naiveProxy/src && ./get-clang.sh
	cd naiveProxy/src && ./build.sh
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




showRunHelpListLast += n05 

.PHONY : x1 x2 c1 conf
