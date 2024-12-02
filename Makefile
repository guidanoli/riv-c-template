NAME= hello
COMPRESSION= xz

OUT_DIR= out

CARTRIDGE= $(OUT_DIR)/$(NAME).sqfs
RELEASE_ELF= $(OUT_DIR)/0-$(NAME).release.elf
OPTIMIZED_RELEASE_ELF= $(OUT_DIR)/0-$(NAME).optimized.release.elf
DEBUG_ELF= $(OUT_DIR)/0-$(NAME).debug.elf

RIVEMU= rivemu
RIVEMU_RUN= $(RIVEMU)
RIVEMU_EXEC= $(RIVEMU) -quiet -no-window -sdk -workspace -exec
RIVEMU_EXECIT= $(RIVEMU) -quiet -sdk -workspace -it -exec
ifneq (,$(wildcard /usr/sbin/riv-run))
	RIVEMU_RUN=riv-run
	RIVEMU_EXEC=
	RIVEMU_EXECIT=
endif

SRC_FILES= src/main.c

RELEASE_CFLAGS= $(shell $(RIVEMU_EXEC) riv-opt-flags -Ospeed)
DEBUG_CFLAGS= $(shell $(RIVEMU_EXEC) riv-opt-flags -Odebug)

.PHONY: build
build: $(CARTRIDGE)

.PHONY: setup
setup: libriv/riv.h

libriv/riv.h: $(shell which $(RIVEMU)) | libriv
	$(RIVEMU_EXEC) cp /usr/include/riv.h $@

libriv:
	mkdir -p $@

.PHONY: run
run: $(CARTRIDGE)
	$(RIVEMU_RUN) $<

.PHONY: debug
debug: $(DEBUG_ELF)
	$(RIVEMU_EXECIT) gdb -silent $<

.PHONY: clean
clean:
	rm -rf $(OUT_DIR)

$(CARTRIDGE): $(OPTIMIZED_RELEASE_ELF) | $(OUT_DIR)
	$(RIVEMU_EXEC) riv-mksqfs $^ $@ -comp $(COMPRESSION)

$(OPTIMIZED_RELEASE_ELF): $(RELEASE_ELF) | $(OUT_DIR)
	$(RIVEMU_EXEC) riv-strip $^ -o $@

$(RELEASE_ELF): $(SRC_FILES) | $(OUT_DIR)
	$(RIVEMU_EXEC) gcc $^ -o $@ $(RELEASE_CFLAGS)

$(DEBUG_ELF): $(SRC_FILES) | $(OUT_DIR)
	$(RIVEMU_EXEC) gcc $^ -o $@ $(DEBUG_CFLAGS)

$(OUT_DIR):
	mkdir -p $@
