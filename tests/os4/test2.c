// ppc-amigaos-g++ -athread=native test2.c -o test2

#include <iostream>
#include <thread>
 
//This function will be called from a thread
 
void call_from_thread() {
    std::cout << "only 1200, only hardcore" << std::endl;
}
 
int main() {
    //Launch a thread
    std::thread t1(call_from_thread);
 
    //Join the thread with the main thread
    t1.join();
 
    return 0;
}