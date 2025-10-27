NAME = tests

ASM = nasm
ASM_FLAGS = -f elf64
ASM_DFLAGS = -g -F dwarf
LINKER = ld

CC = cc
CFLAGS = -Wall -Wextra -Werror

ASM_SRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
ASM_OBJ = $(ASM_SRC:.s=.o)

C_SRC = main.c
C_OBJ = $(C_SRC:.c=.o)

TEST_FILES = test_mine.txt test_original.txt test_wrong_permissions.txt

all: $(NAME)

$(NAME): $(ASM_OBJ) $(C_OBJ)
	$(CC) $(CFLAGS) $(ASM_OBJ) $(C_OBJ) -o $(NAME)

%.o: %.s
	$(ASM) $(ASM_FLAGS) $(ASM_DFLAGS) $< -o $@

$(C_OBJ): $(C_SRC)
	$(CC) $(CFLAGS) -c $(C_SRC) -o $(C_OBJ)

clean:
	rm -f $(ASM_OBJ) $(C_OBJ) $(NAME) $(TEST_FILES)

re: clean all

run: $(NAME)
	./$(NAME)

valgrind: $(NAME)
	valgrind --leak-check=full --track-fds=yes ./$(NAME) 

.PHONY: all clean run valgrind
