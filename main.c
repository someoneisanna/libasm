#include "libasm.h"

int main()
{
	printf("\nFT_STRLEN *************************************************\n\n");
	
	char *t1 = "";
	char *t2 = "Hello, World!";
	char *t3 = "This is a longer string to test the ft_strlen function. It will have 500 characters. eilbhv hilywiwufvhbwicwiaep09cvwivcwjk vikwb clwmjooooooobilgyovle.jbvlwiyfuacawgkawutcwu vdh3fr423u5479137597efhdvbh,kagkir63ti686i3t83pcovugv kdbevk.e.nkvbek.hvfewifgawcoqvbgceui3riwo4ry79lwoehf.ewu58151091	i0+fkScn.drjkugotwecofugw3ohfwe-cfvns,hefgyr8ow4yt0orumj 97efhdvbh,kagkir63ti686i3t83pcovugv kdbevk.e.nkvbek.hvfewifgawcoqvbgceui3riwo4ry79lwoehf.ewu58151091	i*+fkScn.drjkugotwecofugw3ohfwe-,fugdwutfvwukv,k";
	
	printf("t1 length | mine: %-4li | original: %-4li\n", ft_strlen(t1), strlen(t1));
	printf("t2 length | mine: %-4li | original: %-4li\n", ft_strlen(t2), strlen(t2));
	printf("t3 length | mine: %-4li | original: %-4li\n", ft_strlen(t3), strlen(t3));

	printf("\nFT_STRCPY *************************************************\n\n");

	char dest1[60];
	char dest2[60];
	char dest3[600];
	char dest4[600];

	printf("t1 copy  | mine: '%s' | original: '%s'\n", ft_strcpy(dest1, t1), strcpy(dest2, t1));
	printf("t2 copy  | mine: '%s' | original: '%s'\n", ft_strcpy(dest1, t2), strcpy(dest2, t2));
	printf("t3 copy  |\nmine:     '%s'\noriginal: '%s'\n", ft_strcpy(dest3, t3), strcpy(dest4, t3));

	printf("\nFT_STRCMP *************************************************\n\n");

	char *t4 = "";
	char *t5 = "Hello, World!";
	char *t6 = "This is a longer string to test the ft_strlen function. It will have 500 characters. eilbhv hilywiwufvhbwicwiaep09cvwivcwjk vikwb clwmjooooooobilgyovle.jbvlwiyfuacawgkawutcwu vdh3fr423u5479137597efhdvbh,kagkir63ti686i3t83pcovugv kdbevk.e.nkvbek.hvfewifgawcoqvbgceui3riwo4ry79lwoehf.ewu58151091	i0+fkScn.drjkugotwecofugw3ohfwe-cfvns,hefgyr8ow4yt0orumj 97efhdvbh,kagkir63ti686i3t83pcovugv kdbevk.e.nkvbek.hvfewifgawcoqvbgceui3riwo4ry79lwoehf.ewu58151091	i*+fkScn.drjkugotwecofugw3ohfwe-,fugdwutfvwukv,k";
	char *t7 = "Hello, World?";
	char *t8 = "Hello, world!";
	char *t9 = "Hello, World!Some extra text.";
	char *t10 = "Hello, Worl";

	printf("t1 vs t4  | mine: %-3d | original: %-3d\n", ft_strcmp(t1, t4), strcmp(t1, t4));
	printf("t2 vs t5  | mine: %-3d | original: %-3d\n", ft_strcmp(t2, t5), strcmp(t2, t5));
	printf("t3 vs t6  | mine: %-3d | original: %-3d\n", ft_strcmp(t3, t6), strcmp(t3, t6));
	printf("t1 vs t1  | mine: %-3d | original: %-3d\n", ft_strcmp(t1, t1), strcmp(t1, t1));
	printf("t2 vs t7  | mine: %-3d | original: %-3d\n", ft_strcmp(t2, t7), strcmp(t2, t7));    // ! = 33 and ? = 63  in ASCII -> difference of -30
	printf("t2 vs t8  | mine: %-3d | original: %-3d\n", ft_strcmp(t2, t8), strcmp(t2, t8));    // W = 87 and w = 119 in ASCII -> difference of -32
	printf("t2 vs t9  | mine: %-3d | original: %-3d\n", ft_strcmp(t2, t9), strcmp(t2, t9));    // shorter vs longer string, should return negative (S = 83)
	printf("t2 vs t10 | mine: %-3d | original: %-3d\n", ft_strcmp(t2, t10), strcmp(t2, t10));  // longer vs shorter string, should return positive (d = 100)

	printf("\nFT_WRITE **************************************************\n\n");

	int fd1 = open("test_mine.txt", O_CREAT | O_WRONLY | O_TRUNC, 0644);
	int fd2 = open("test_original.txt", O_CREAT | O_WRONLY | O_TRUNC, 0644);
	int fd3 = open("test_wrong_permissions.txt", O_CREAT | O_RDONLY, 0644);

	printf("t1 to STDOUT                 | mine: %-13li  | original: %-13li\n", ft_write(1, t1, strlen(t1)), write(1, t1, strlen(t1)));
	printf("\nt2 to STDOUT                 | mine: %-13li  | original: %-13li\n", ft_write(1, t2, strlen(t2)), write(1, t2, strlen(t2)));
	printf("t3 to test.txt               | mine: %-13li  | original: %-13li\n", ft_write(fd1, t3, strlen(t3)), write(fd2, t3, strlen(t3)));
	printf("\nt2 with less bytes to STDOUT | mine: %-13li  | original: %-13li\n", ft_write(1, t2, 5), write(1, t2, 5));
	printf("t2 with zero bytes to STDOUT | mine: %-13li  | original: %-13li\n", ft_write(1, t2, 0), write(1, t2, 0));

	errno = 0;
	ssize_t ret = ft_write(-1, t2, strlen(t2));
	printf("t2 to invalid fd (-1)        | mine: %li + errno: %d  | original: ", ret, errno);
	errno = 0;
	ret = write(-1, t2, strlen(t2));
	printf("%li + errno: %d\n", ret, errno);
	
	errno = 0;
	ret = ft_write(fd3, t2, strlen(t2));
	printf("t2 to wrong permissions fd   | mine: %li + errno: %d  | original: ", ret, errno);
	errno = 0;
	ret = write(fd3, t2, strlen(t2));
	printf("%li + errno: %d\n", ret, errno);

	errno = 0;
	char *invalid_ptr = (char *)0; // deliberately invalid memory
	ret = ft_write(1, invalid_ptr, 10);
	printf("invalid ptr to STDOUT        | mine: %li + errno: %d | original: ", ret, errno);
	ret = write(1, invalid_ptr, 10);
	printf("%li + errno: %d\n", ret, errno);

	close(fd1);
	close(fd2);
	close(fd3);

	printf("\nFT_READ ***************************************************\n\n");

	char buffer1[600];
	char buffer2[600];
	
	fd1 = open("test_original.txt", O_RDONLY);
	fd2 = open("test_mine.txt", O_RDONLY);
	ret = ft_read(fd2, buffer1, 500);
	buffer1[ret] = '\0';
	printf("read from test_mine.txt      | mine: %-5li     -> content: '%s'\n", ret, buffer1);
	ret = read(fd1, buffer2, 500);
	buffer2[ret] = '\0';
	printf("read from test_original.txt  | original: %-5li -> content: '%s'\n", ret, buffer2);
	close(fd1);
	close(fd2);

	fd1 = open("test_original.txt", O_RDONLY);
	fd2 = open("test_mine.txt", O_RDONLY);
	ret = ft_read(fd2, buffer1, 50);
	buffer1[ret] = '\0';
	printf("\nread next 50 bytes mine      | mine: %-5li     -> content: '%s'\n", ret, buffer1);
	ret = read(fd1, buffer2, 50);
	buffer2[ret] = '\0';
	printf("read next 50 bytes original  | original: %-5li -> content: '%s'\n", ret, buffer2);
	close(fd1);
	close(fd2);

	fd1 = open("test_original.txt", O_RDONLY);
	fd2 = open("test_mine.txt", O_RDONLY);
	ret = ft_read(fd2, buffer1, 0);
	buffer1[ret] = '\0';
	printf("\nread zero bytes mine         | mine: %-5li     -> content: '%s'\n", ret, buffer1);
	ret = read(fd1, buffer2, 0);
	buffer2[ret] = '\0';
	printf("read zero bytes original     | original: %-5li -> content: '%s'\n", ret, buffer2);
	close(fd1);
	close(fd2);

	errno = 0;
	fd1 = -1;
	ret = ft_read(fd1, buffer1, 100);
	printf("\nread from invalid fd (-1)    | mine: %li + errno: %d  | original: ", ret, errno);
	errno = 0;
	ret = read(fd1, buffer2, 100);
	printf("%li + errno: %d\n", ret, errno);
	
	errno = 0;
	fd2 = open("test_wrong_permissions.txt", O_WRONLY);
	ret = ft_read(fd2, buffer1, 100);
	printf("read from wrong permissions  | mine: %li + errno: %d  | original: ", ret, errno);
	errno = 0;
	ret = read(fd2, buffer2, 100);
	printf("%li + errno: %d\n", ret, errno);
	close(fd2);

	errno = 0;
	fd2 = open(".", O_RDONLY, 0666);
	ret = ft_read(fd2, buffer1, 100);
	printf("read directory               | mine: %li + errno: %d | original: ", ret, errno);
	errno = 0;
	ret = read(fd2, buffer2, 100);
	printf("%li + errno: %d\n", ret, errno);
	close(fd2);

	printf("\nFT_STRDUP *************************************************\n\n");

	char *dup1 = ft_strdup(t1);
	char *dup2 = strdup(t1);

	printf("dup t1    | mine: '%s' | original: '%s'\n", dup1, dup2);
	free(dup1);
	free(dup2);
	
	dup1 = ft_strdup(t2);
	dup2 = strdup(t2);
	printf("dup t2    | mine: '%s' | original: '%s'\n", dup1, dup2);
	free(dup1);
	free(dup2);

	dup1 = ft_strdup(t3);
	dup2 = strdup(t3);
	printf("dup t3    |\nmine:     '%s'\noriginal: '%s'\n", dup1, dup2);
	free(dup1);
	free(dup2);
}

