OUT = test
CXX := clang++
TARGET := x86_64-pc-windows-gnu
SRC = src/dllmain.cpp src/SigScan.cpp
OBJ = ${addprefix ${TARGET}/,${subst .c,.o,${SRC:.cpp=.o}}}
CXXFLAGS = -std=c++17 -Wall -Ofast -target ${TARGET} -DWIN32_LEAN_AND_MEAN -D_WIN32_WINNT=_WIN32_WINNT_WIN7
LDFLAGS := -shared -static -static-libgcc -s -pthread -lgdi32 -ldwmapi -ld3dcompiler

all: options ${OUT}

.PHONY: options
options:
	@echo "CXXFLAGS	= ${CXXFLAGS}"
	@echo "LDFLAGS	= ${LDFLAGS}"
	@echo "CXX	= ${CXX}"

.PHONY: dirs
dirs:
	@mkdir -p ${TARGET}/src

${TARGET}/%.o: %.cpp
	@echo BUILD $@
	@${CXX} -c ${CXXFLAGS} $< -o $@

${TARGET}/%.o: %.c
	@echo BUILD $@
	@${CXX} -c ${CXXFLAGS} $< -o $@

.PHONY: ${OUT}
${OUT}: dirs ${OBJ}
	@echo LINK $@
	@${CXX} ${CXXFLAGS} -o ${TARGET}/$@.dll ${OBJ} ${LDFLAGS} ${LIBS}

.PHONY: fmt
fmt:
	@cd src && clang-format -i *.h *.cpp -style=file

.PHONY: clean
clean:
	rm -rf ${TARGET}
