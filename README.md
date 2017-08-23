# Puma memory usage problem

## Preparation

Generate big json file (9,1M) using:

    ./generate-file

## Using puma with one thread

Run server:

    puma -p 3000 -e production -t 1:1

Make few curl requests and see how memory is growing (it stopped growing at about 410 MB on third request when I was testing):

    for i in {1..5}; do curl http://localhost:3000; done

Puma output:

    Initial memory usage: 20120 kB
    Request #1: 183596 kB > 242676 kB > 245392 kB > 269264 kB > 269264 kB > 334932 kB > 353464 kB > 345516 kB > 324300 kB > 351472 kB >
    Request #2: 373436 kB > 373436 kB > 373436 kB > 373436 kB > 373436 kB > 373700 kB > 391720 kB > 391720 kB > 391720 kB > 444820 kB >
    Request #3: 452476 kB > 452476 kB > 470480 kB > 470480 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB >
    Request #4: 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB >
    Request #5: 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB > 449068 kB >

## Using puma with 20 threads

Run server:

    puma -p 3000 -e production -t 20:20

Make few curl requests again (memory usage after 20 request is equal 4GB!):

    for i in {1..20}; do curl http://localhost:3000; done

Puma output:

    Initial memory usage: 20292 kB
    Request #1: 185628 kB > 258300 kB > 352924 kB > 358544 kB > 358544 kB > 358544 kB > 358544 kB > 362172 kB > 377872 kB > 378128 kB >
    Request #2: 463236 kB > 629932 kB > 698296 kB > 707064 kB > 707064 kB > 692960 kB > 692960 kB > 692960 kB > 692960 kB > 692960 kB >
    Request #3: 791876 kB > 878316 kB > 887548 kB > 878488 kB > 878488 kB > 878488 kB > 878488 kB > 878488 kB > 878488 kB > 878488 kB >
    Request #4: 977404 kB > 1063844 kB > 1063844 kB > 1063844 kB > 1063844 kB > 1063844 kB > 1063844 kB > 1063844 kB > 1063844 kB > 1063844 kB >
    Request #5: 1162760 kB > 1249200 kB > 1249200 kB > 1249200 kB > 1249200 kB > 1249200 kB > 1249200 kB > 1249200 kB > 1249200 kB > 1249200 kB >
    Request #6: 1348116 kB > 1434556 kB > 1434556 kB > 1434556 kB > 1434556 kB > 1434556 kB > 1434556 kB > 1434556 kB > 1434556 kB > 1434556 kB >
    Request #7: 1533472 kB > 1619912 kB > 1629144 kB > 1621156 kB > 1630384 kB > 1621196 kB > 1630424 kB > 1621200 kB > 1630428 kB > 1621200 kB >
    Request #8: 1720116 kB > 1806556 kB > 1806556 kB > 1806556 kB > 1806556 kB > 1806556 kB > 1806556 kB > 1806556 kB > 1806556 kB > 1806556 kB >
    Request #9: 1905472 kB > 1991912 kB > 1991912 kB > 1991912 kB > 1991912 kB > 1991912 kB > 1991912 kB > 1991912 kB > 1991912 kB > 1991912 kB >
    Request #10: 2090828 kB > 2177268 kB > 2177268 kB > 2177268 kB > 2177268 kB > 2177268 kB > 2177268 kB > 2177268 kB > 2177268 kB > 2177268 kB >
    Request #11: 2276184 kB > 2362624 kB > 2371856 kB > 2362776 kB > 2362776 kB > 2372004 kB > 2362776 kB > 2362776 kB > 2362776 kB > 2362776 kB >
    Request #12: 2461692 kB > 2548132 kB > 2548132 kB > 2548132 kB > 2548132 kB > 2548132 kB > 2548132 kB > 2548132 kB > 2548132 kB > 2548132 kB >
    Request #13: 2647048 kB > 2733488 kB > 2733488 kB > 2733488 kB > 2733488 kB > 2733488 kB > 2733488 kB > 2733488 kB > 2733488 kB > 2733488 kB >
    Request #14: 2832404 kB > 2918844 kB > 2918844 kB > 2918844 kB > 2918844 kB > 2918844 kB > 2918844 kB > 2918844 kB > 2918844 kB > 2918844 kB >
    Request #15: 3017760 kB > 3104200 kB > 3104200 kB > 3104200 kB > 3104200 kB > 3104200 kB > 3104200 kB > 3104200 kB > 3104200 kB > 3104200 kB >
    Request #16: 3203116 kB > 3289556 kB > 3289556 kB > 3289556 kB > 3289556 kB > 3289556 kB > 3289556 kB > 3289556 kB > 3289556 kB > 3289556 kB >
    Request #17: 3388472 kB > 3474912 kB > 3474912 kB > 3474912 kB > 3474912 kB > 3474912 kB > 3474912 kB > 3474912 kB > 3474912 kB > 3474912 kB >
    Request #18: 3573828 kB > 3660268 kB > 3660268 kB > 3660268 kB > 3660268 kB > 3660268 kB > 3660268 kB > 3660268 kB > 3660268 kB > 3660268 kB >
    Request #19: 3759184 kB > 3845708 kB > 3845708 kB > 3845708 kB > 3845708 kB > 3845708 kB > 3845708 kB > 3845708 kB > 3845708 kB > 3845708 kB >
    Request #20: 3944708 kB > 4030968 kB > 4030968 kB > 4030968 kB > 4030968 kB > 4030968 kB > 4030968 kB > 4030968 kB > 4030968 kB > 4030968 kB >

## The same can be observed using thin

Run server:

    thin -R config.ru -a localhost -p 3000 --threaded --threadpool-size 20 start

Make few curl requests:

    for i in {1..20}; do curl http://localhost:3000; done

Output:

    Initial memory usage: 23932 kB
    Request #1: 189484 kB > 293836 kB > 279592 kB > 288924 kB > 298152 kB > 331816 kB > 331816 kB > 331816 kB > 331816 kB > 355236 kB >
    Request #2: 464184 kB > 576300 kB > 604072 kB > 604072 kB > 604072 kB > 604072 kB > 635880 kB > 664180 kB > 664180 kB > 664180 kB >
    Request #3: 763096 kB > 759788 kB > 742884 kB > 890516 kB > 919872 kB > 920928 kB > 928448 kB > 1005784 kB > 1012912 kB > 1012912 kB >
    Request #4: 1111828 kB > 1187908 kB > 1201828 kB > 1211116 kB > 1211116 kB > 1211116 kB > 1211116 kB > 1211116 kB > 1211116 kB > 1211116 kB >
    Request #5: 1291728 kB > 1369392 kB > 1369392 kB > 1369392 kB > 1369392 kB > 1369392 kB > 1369392 kB > 1369392 kB > 1369392 kB > 1369392 kB >
    Request #6: 1468308 kB > 1546240 kB > 1564764 kB > 1555712 kB > 1555972 kB > 1555972 kB > 1555972 kB > 1555972 kB > 1555972 kB > 1555972 kB >
    Request #7: 1654888 kB > 1732820 kB > 1732820 kB > 1732820 kB > 1732820 kB > 1732820 kB > 1732820 kB > 1732820 kB > 1732820 kB > 1732820 kB >
    Request #8: 1831736 kB > 1909668 kB > 1913556 kB > 1914608 kB > 1914608 kB > 1914608 kB > 1914608 kB > 1914608 kB > 1914608 kB > 1914608 kB >
    Request #9: 2013524 kB > 2091456 kB > 2095344 kB > 2096396 kB > 2096396 kB > 2096396 kB > 2096396 kB > 2096396 kB > 2096396 kB > 2096396 kB >
    Request #10: 2195312 kB > 2273244 kB > 2273244 kB > 2273244 kB > 2273244 kB > 2273244 kB > 2273244 kB > 2273244 kB > 2273244 kB > 2273244 kB >
    Request #11: 2372160 kB > 2450092 kB > 2450092 kB > 2450092 kB > 2468616 kB > 2459568 kB > 2459828 kB > 2473216 kB > 2464152 kB > 2464152 kB >
    Request #12: 2563068 kB > 2640216 kB > 2640216 kB > 2640216 kB > 2640216 kB > 2640216 kB > 2640216 kB > 2640216 kB > 2640216 kB > 2640216 kB >
    Request #13: 2739216 kB > 2816304 kB > 2816304 kB > 2816304 kB > 2816304 kB > 2816304 kB > 2816304 kB > 2816304 kB > 2816304 kB > 2816304 kB >
    Request #14: 2915304 kB > 2992392 kB > 2992392 kB > 2992392 kB > 2992392 kB > 2992392 kB > 2992392 kB > 2992392 kB > 2992392 kB > 2992392 kB >
    Request #15: 3091392 kB > 3168480 kB > 3186960 kB > 3177920 kB > 3178972 kB > 3178972 kB > 3178972 kB > 3178972 kB > 3178972 kB > 3178972 kB >
    Request #16: 3277964 kB > 3355052 kB > 3355052 kB > 3355052 kB > 3355052 kB > 3355052 kB > 3355052 kB > 3355052 kB > 3355052 kB > 3355052 kB >
    Request #17: 3454052 kB > 3531140 kB > 3531140 kB > 3531140 kB > 3531140 kB > 3531140 kB > 3531140 kB > 3531140 kB > 3531140 kB > 3531140 kB >
    Request #18: 3630140 kB > 3707228 kB > 3707228 kB > 3707228 kB > 3707228 kB > 3707228 kB > 3707228 kB > 3707228 kB > 3707228 kB > 3707228 kB >
    Request #19: 3806228 kB > 3883316 kB > 3901796 kB > 3892744 kB > 3893796 kB > 3893796 kB > 3893796 kB > 3893796 kB > 3893796 kB > 3893796 kB >
    Request #20: 3992796 kB > 4069816 kB > 4069816 kB > 4069816 kB > 4069816 kB > 4069816 kB > 4069816 kB > 4069816 kB > 4069816 kB > 4069816 kB >

## I tried recreate this without puma (just plain ruby threads)

    ruby -r./app.rb -e "20.times { Thread.new { App.call(nil) }.join }"

but without success:

    Initial memory usage: 9056 kB
    Request #1: 175000 kB > 203480 kB > 214012 kB > 323820 kB > 323820 kB > 333052 kB > 323884 kB > 323884 kB > 323884 kB > 350144 kB >
    Request #2: 364264 kB > 348616 kB > 348616 kB > 349404 kB > 349404 kB > 349404 kB > 350196 kB > 340624 kB > 340624 kB > 340624 kB >
    Request #3: 363516 kB > 384624 kB > 384624 kB > 384624 kB > 384624 kB > 384624 kB > 384624 kB > 384624 kB > 417888 kB > 427128 kB >
    Request #4: 427200 kB > 427200 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #5: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #6: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #7: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #8: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #9: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #10: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #11: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #12: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #13: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #14: 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB > 414088 kB >
    Request #15: 414088 kB > 414088 kB > 414088 kB > 444964 kB > 514048 kB > 544136 kB > 544136 kB > 544136 kB > 544136 kB > 544136 kB >
    Request #16: 546452 kB > 546452 kB > 546452 kB > 546452 kB > 546452 kB > 546452 kB > 546452 kB > 546452 kB > 546452 kB > 546452 kB >
    Request #17: 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB >
    Request #18: 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB >
    Request #19: 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB >
    Request #20: 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB > 546624 kB >
