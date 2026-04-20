PACKAGE=bggit
WEB_IMAGES=$(wildcard src/img_*.svg src/img_*.png)

BGBSPD_BUILD_DIR?=../bgbspd

include $(BGBSPD_BUILD_DIR)/main.make
