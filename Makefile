MAKEFLAGS += --no-builtin-rules --warn-undefined-variables
include Makefile.common

STD:=std
SES:=session

# Contracts
T:=Repo
B:=BlockDevice
D:=DataVolume
F:=Stat
I:=InputParser
C:=CommandProcessor
O:=Options
S:=SuperBlock
R:=FileReader
INIT:=$T
TA:=$D $F $B $I $C $O $S $R
#TA:=$S $T
RKEYS:=$(KEY)/k1.keys
VAL0:=15

PHONY += all genaddr init deploy balances compile clean brief
all: compile

#clean:
#	for d in $(DIRS); do (cd "$$d" && rm -f *); done

DEPLOYED=$(patsubst %,$(BLD)/%.deployed,$(INIT))

cc: $(patsubst %,$(BLD)/%.tvc,$(INIT) $(TA))
	du -sb $^
deploy: $(DEPLOYED)
	-cat $^
$(BLD)/%.code $(BLD)/%.abi.json: $(SRC)/%.sol
	$(SOLC) $< -o $(BLD)

$(BLD)/%.tvc: $(BLD)/%.code $(BLD)/%.abi.json
	$(LINKER) compile --lib $(LIB) $< -a $(word 2,$^) -o $@

$(BLD)/%.shift: $(BLD)/%.tvc $(BLD)/%.abi.json $(RKEYS)
	$(TOC) genaddr $< $(word 2,$^) --setkey $(word 3,$^) | grep "Raw address:" | sed 's/.* //g' >$@

$(BLD)/%.cargs:
	$(file >$@,{})

$(BLD)/%.deployed: $(BLD)/%.shift $(BLD)/%.tvc $(BLD)/%.abi.json $(RKEYS) $(BLD)/%.cargs
	$(call _pay,$(file < $<),$(VAL0))
	$(TOC) deploy $(word 2,$^) --abi $(word 3,$^) --sign $(word 4,$^) $(word 5,$^) >$@

$(BLD)/%.stateInit: $(BLD)/%.tvc
	$(BASE64) $< >$@

define t-addr
$$(eval $1_a!=grep $1 etc/hosts | cut -f 1)
$(STD)/$1/upgrade.args: $(BLD)/$1.stateInit
	$$(file >$$@,$$(call _args,c,$$(file <$$<)))
endef

$(foreach c,$(TA),$(eval $(call t-addr,$c)))

define t-call
$(STD)/$1/$2.res: $(STD)/$1/$2.args
	$(TOC) call $$($1_a) --abi $(BLD)/$1.abi.json $2 $$(word 1,$$^) >$$@
endef

define t-run
$(STD)/$1/$2.out:
	$(TOC) -j run $$($1_a) --abi $(BLD)/$1.abi.json $2 {} >$$@
endef

_d=init upgrade
$(foreach b,$(TA),$(foreach c,$(_d),$(eval $(call t-call,$b,$c))))

$(STD)/read.out: $(STD)/read.args
	$(TOC) -j run $($B_a) --abi $(BLD)/$B.abi.json read $< >$@

$(STD)/write.res: $(STD)/write.args
	$(TOC) call $($B_a) --abi $(BLD)/$B.abi.json put $< >$@

$(STD)/parse.out: $(STD)/parse.args
	$(TOC) -j run $($I_a) --abi $(BLD)/$I.abi.json parse $(word 1,$^) >$@
	jq -r '.action' < $@ >$(STD)/action
$(STD)/stat.out: $(STD)/stat.args
	$(TOC) -j run $($F_a) --abi $(BLD)/$F.abi.json fstat $(word 1,$^) >$@
	jq -r '.action' < $@ >$(STD)/action2
$(STD)/process.out: $(STD)/process.args
	$(TOC) -j run $($C_a) --abi $(BLD)/$C.abi.json process $(word 1,$^) >$@
	jq -r '.action' < $@ >$(STD)/action3

u_%: $(STD)/%/upgrade.args
	$(TOC) call $($*_a) --abi $(BLD)/$*.abi.json upgrade $(word 1,$^)
i_%:
	$(TOC) call $($*_a) --abi $(BLD)/$*.abi.json init {}

define t-dump
$$(foreach r,$$(pv_$1),$$(eval $$(call t-run,$1,$$r)))

d_$1: $$(patsubst %,$(STD)/$1/%.out,$$(pv_$1))
	jq -r '.' <$$<
endef
pv_FSync:=_init_ids _inodes _ugroups _users  _dc
pv_$C=$(pv_FSync)
pv_$F=$(pv_FSync)
pv_$S=$(pv_FSync)
pv_$R=$(pv_FSync)
pv_$I=$(pv_FSync) _command_names
pv_$B=$(pv_FSync) _dev _cdata _char_dev
pv_$D=_exports _command_names _error_text
pv_$O=_exports

$(foreach c,$(TA),$(eval $(call t-dump,$c)))

tt: bin/xterm
	./$<
bin/xterm: $(SRC)/xterm.c
	gcc $< -o $@

$(SYS)/%.args:
	$(file >$@,{})

#include Disk.make

PHONY += FORCE
FORCE:

.PHONY: $(PHONY)

V?=
$(V).SILENT:
