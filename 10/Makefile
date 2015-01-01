.SUFFIXES: .erl .beam

.erl.beam:
	erlc -W $<

ERL = erl -boot start_clean

MODS = geometry

all: compile

compile: ${MODS:%=%.beam}

test: compile 
	${ERL} -noshell -s geometry test_perimiter\
	    -s geometry test_area\
	    -s init stop

clean:
	rm -rf *.beam erl_crash.dump
