#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include <signal.h>

int secret() {
char secret[17];
FILE *file;
file = fopen("/home/user/Desktop/secret.txt", "r");
fgets(secret, sizeof(secret), file);
printf("%s", secret);
return 0;
}
int vuln() {
char password[##passwordbuff##];
char username[##usernamebuff##];
char password_input[##inputbuff##];
char flag[17];
FILE *file;

   printf("\\nYour input starts at %p\\n", username);
   printf("\\nNeed to get to %p\\n", secret);
   printf("Enter Username: \\n");
   gets(username);
   strcat(username, "\\nEnter Password: ");

   file = fopen("/home/user/Desktop/password.txt", "r");
   fgets(password, sizeof(password), file);
   printf("Hello, %s", username);
   fgets(password_input, sizeof(password_input), stdin);

   if (strstr(password_input, password) != NULL) {
	   printf("Access granted, Flag is :\\n");
           FILE *file;
	   file = fopen("/home/user/Desktop/login.txt", "r");
	   fgets(flag, sizeof(flag), file);
	   printf("%s", flag);
	   return 0;
   }
   else {
	   printf("Incorrect login.\\n");
   }
   return 0;
}

void handler(int nSignum){
register uintptr_t esp asm ("esp");
uintptr_t* plus = esp+0x5c;
printf("Caught Seg fault\nESP: 0x%08" PRIxPTR "\n", *plus);
exit(1);
}

int main(int argc, char **argv) {
signal(SIGSEGV, handler);
setvbuf(stdout, NULL, _IONBF, 0);
vuln();
}

