NAME = libasm.a

AR = ar rcs

ASM = nasm
ASM_FLAGS = -f elf64

CC = cc
CFLAGS = -Wall -Wextra -Werror

ASM_SRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
ASM_OBJ = $(ASM_SRC:.s=.o)

C_SRC = main.c
C_OBJ = main.o

TEST_EXE = libasm_test
TEST_FILES = test_mine.txt test_original.txt test_wrong_permissions.txt

all: $(NAME)

$(NAME): $(ASM_OBJ)
	$(AR) $(NAME) $(ASM_OBJ)

%.o: %.s
	$(ASM) $(ASM_FLAGS) $< -o $@

$(C_OBJ): $(C_SRC)
	$(CC) $(CFLAGS) -c $(C_SRC) -o $(C_OBJ)

run: $(TEST_EXE)
	./$(TEST_EXE)

$(TEST_EXE): $(NAME) $(C_OBJ)
	$(CC) $(CFLAGS) $(C_OBJ) -L. -lasm -o $(TEST_EXE)

valgrind: run
	valgrind --leak-check=full --track-fds=yes ./$(TEST_EXE)

clean:
	rm -f $(ASM_OBJ) $(C_OBJ)

fclean: clean
	rm -f $(NAME) $(TEST_EXE) $(TEST_FILES)

re: clean all

.PHONY: all clean run valgrind
