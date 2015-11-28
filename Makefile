build:
	xcodebuild -configuration Release

clean:
	rm -rf build/

install:
ifdef THEOS_DEVICE_IP
	xcodebuild -configuration Release
	ssh root@$(THEOS_DEVICE_IP) "rm -rf /Applications/iNDS.app"
	scp -r build/Release-iphoneos/iNDS.app root@$(THEOS_DEVICE_IP):/Applications/
	ssh root@$(THEOS_DEVICE_IP) "chown mobile:mobile -R /Applications/iNDS.app && su mobile -c uicache"
else
	@echo "iOS device not found!"
	@echo "Did you forget to define THEOS_DEVICE_IP?"
	@echo "Ex: export THEOS_DEVICE_IP=<your iOS device's IP address>"
endif
