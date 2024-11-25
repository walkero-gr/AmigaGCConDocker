// ppc-amigaos-gcc -mcrt=newlib curl.c -o curl -lcurl -lrtmp -lssl -lcrypto -lz -lpthread -athread=native
// ppc-amigaos-gcc -mcrt=clib4 curl.c -o curl-clib4 -lcurl -lrtmp -lssl -lcrypto -lz -lbrotlidec -lbrotlicommon -lnghttp2 -lpsl -lidn2 -lunistring -lpthread -athread=native

#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <curl/curl.h>

int main(void)
{
  CURL *curl;
  CURLcode res;

  curl = curl_easy_init();
  if(curl) {
    curl_easy_setopt(curl, CURLOPT_URL, "https://www.amiga.gr/");
    res = curl_easy_perform(curl);

    if(CURLE_OK == res) {
      char *ct;
      /* ask for the content-type */
      res = curl_easy_getinfo(curl, CURLINFO_CONTENT_TYPE, &ct);

      if((CURLE_OK == res) && ct)
        printf("We received Content-Type: %s\n", ct);
    }

    /* always cleanup */
    curl_easy_cleanup(curl);
  }
  return 0;
}
