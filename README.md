# Puma (ruby threads) memory usage problem

## Using puma with one thread

Run server:

    puma -p 3000 -e production -t 1:1

Make few curl requests and see how memory is growing (it stopped growing at about 410 MB on third request when I was testing):

    for i in {1..5}; do curl http://localhost:3000; done

Puma output:

    Initial memory usage: 19224 kB
    Request #1: 68328 kB > 117432 kB > 117696 kB > 165216 kB > 165216 kB > 150428 kB > 150428 kB > 150428 kB > 150428 kB > 157024 kB >
    Request #2: 157024 kB > 150588 kB > 150588 kB > 150588 kB > 150588 kB > 167480 kB > 170120 kB > 170120 kB > 170120 kB > 170120 kB >
    Request #3: 170120 kB > 187280 kB > 187280 kB > 187280 kB > 187280 kB > 187280 kB > 187280 kB > 187280 kB > 187280 kB > 187280 kB >
    Request #4: 187280 kB > 187280 kB > 187280 kB > 187280 kB > 187280 kB > 187280 kB > 187280 kB > 188864 kB > 191504 kB > 193088 kB >
    Request #5: 193352 kB > 193352 kB > 193352 kB > 194408 kB > 194408 kB > 193732 kB > 193732 kB > 193732 kB > 193732 kB > 193732 kB >

## Using puma with 20 threads

Run server:

    puma -p 3000 -e production -t 20:20

Make few curl requests again (memory usage after 20 request is equal 4GB!):

    for i in {1..20}; do curl http://localhost:3000; done

Puma output:

    Initial memory usage: 19780 kB
    Request #1: 68884 kB > 101356 kB > 118252 kB > 149728 kB > 149728 kB > 149728 kB > 149728 kB > 149728 kB > 149728 kB > 151048 kB >
    Request #2: 198980 kB > 234620 kB > 254948 kB > 249888 kB > 260708 kB > 290276 kB > 290276 kB > 281164 kB > 262976 kB > 282772 kB >
    Request #3: 331876 kB > 368308 kB > 402364 kB > 410284 kB > 410548 kB > 420580 kB > 420580 kB > 414176 kB > 414176 kB > 414176 kB >
    Request #4: 463280 kB > 512120 kB > 454944 kB > 454944 kB > 454944 kB > 451448 kB > 458840 kB > 467552 kB > 467552 kB > 479696 kB >
    Request #5: 528800 kB > 545284 kB > 545284 kB > 557688 kB > 557688 kB > 591216 kB > 593592 kB > 603096 kB > 603096 kB > 581740 kB >
    Request #6: 630844 kB > 639704 kB > 639704 kB > 645680 kB > 656240 kB > 663632 kB > 668384 kB > 668648 kB > 686072 kB > 686336 kB >
    Request #7: 735440 kB > 784280 kB > 820600 kB > 780920 kB > 805468 kB > 805732 kB > 805732 kB > 781120 kB > 781120 kB > 773588 kB >
    Request #8: 822692 kB > 847184 kB > 873584 kB > 873584 kB > 889952 kB > 890480 kB > 899984 kB > 916880 kB > 925856 kB > 925856 kB >
    Request #9: 974960 kB > 986740 kB > 1003108 kB > 1035844 kB > 1075972 kB > 1080196 kB > 1080196 kB > 1083364 kB > 1083364 kB > 1083364 kB >
    Request #10: 1022884 kB > 1057732 kB > 1067500 kB > 1071988 kB > 1110796 kB > 1115812 kB > 1122940 kB > 1132180 kB > 1137196 kB > 1138516 kB >
    Request #11: 1187620 kB > 1215004 kB > 1220296 kB > 1240888 kB > 1240888 kB > 1240888 kB > 1240888 kB > 1240888 kB > 1240888 kB > 1240888 kB >
    Request #12: 1289992 kB > 1338832 kB > 1387936 kB > 1411960 kB > 1420144 kB > 1420144 kB > 1420144 kB > 1393968 kB > 1393968 kB > 1405580 kB >
    Request #13: 1454684 kB > 1503524 kB > 1552628 kB > 1583652 kB > 1583652 kB > 1583652 kB > 1583536 kB > 1583536 kB > 1583536 kB > 1583536 kB >
    Request #14: 1632640 kB > 1681480 kB > 1730584 kB > 1741672 kB > 1747216 kB > 1749064 kB > 1749592 kB > 1749592 kB > 1749592 kB > 1688584 kB >
    Request #15: 1737688 kB > 1786528 kB > 1816888 kB > 1818472 kB > 1818472 kB > 1818472 kB > 1830356 kB > 1830620 kB > 1843028 kB > 1846876 kB >
    Request #16: 1895980 kB > 1944820 kB > 1993924 kB > 1979708 kB > 1979708 kB > 1973052 kB > 1973052 kB > 1973052 kB > 1973052 kB > 1973052 kB >
    Request #17: 2022156 kB > 2070996 kB > 2111652 kB > 2114820 kB > 2124324 kB > 2135940 kB > 2139900 kB > 2143596 kB > 2154948 kB > 2155212 kB >
    Request #18: 2204316 kB > 2253156 kB > 2245884 kB > 2218484 kB > 2224012 kB > 2224012 kB > 2196216 kB > 2196216 kB > 2196216 kB > 2196216 kB >
    Request #19: 2245320 kB > 2294160 kB > 2333880 kB > 2359488 kB > 2359752 kB > 2359752 kB > 2359752 kB > 2359752 kB > 2359752 kB > 2346908 kB >
    Request #20: 2396012 kB > 2442984 kB > 2471232 kB > 2471232 kB > 2486808 kB > 2486808 kB > 2499216 kB > 2515928 kB > 2523584 kB > 2523584 kB >

## The same can be observed using thin

Run server:

    thin -R config.ru -a localhost -p 3000 --threaded --threadpool-size 20 start

Make few curl requests:

    for i in {1..20}; do curl http://localhost:3000; done

Output:

    Initial memory usage: 23208 kB
    Request #1: 72308 kB > 105840 kB > 121680 kB > 133032 kB > 153624 kB > 153008 kB > 151056 kB > 151056 kB > 155276 kB > 155276 kB >
    Request #2: 203836 kB > 248676 kB > 276132 kB > 261108 kB > 261108 kB > 261108 kB > 261108 kB > 264536 kB > 297272 kB > 297272 kB >
    Request #3: 330500 kB > 359368 kB > 393424 kB > 406624 kB > 404744 kB > 404744 kB > 404744 kB > 404744 kB > 404744 kB > 404744 kB >
    Request #4: 453848 kB > 502692 kB > 551796 kB > 559188 kB > 559188 kB > 557952 kB > 557952 kB > 557952 kB > 557952 kB > 557952 kB >
    Request #5: 607056 kB > 655900 kB > 696228 kB > 696228 kB > 683848 kB > 683848 kB > 693084 kB > 695460 kB > 704700 kB > 704700 kB >
    Request #6: 733032 kB > 782140 kB > 773248 kB > 773248 kB > 773248 kB > 774828 kB > 804132 kB > 804132 kB > 808356 kB > 808356 kB >
    Request #7: 857460 kB > 905776 kB > 945640 kB > 965176 kB > 955724 kB > 955724 kB > 955724 kB > 931008 kB > 931008 kB > 931008 kB >
    Request #8: 980112 kB > 1010648 kB > 1040216 kB > 1040480 kB > 1055792 kB > 1056056 kB > 1068200 kB > 1089056 kB > 1096184 kB > 1096184 kB >
    Request #9: 1145288 kB > 1159800 kB > 1184204 kB > 1189568 kB > 1189568 kB > 1189568 kB > 1189568 kB > 1189568 kB > 1189568 kB > 1189568 kB >
    Request #10: 1238672 kB > 1287516 kB > 1336620 kB > 1370676 kB > 1376484 kB > 1376484 kB > 1377276 kB > 1377276 kB > 1377276 kB > 1365012 kB >
    Request #11: 1414116 kB > 1389132 kB > 1428468 kB > 1431636 kB > 1431636 kB > 1431636 kB > 1438744 kB > 1444816 kB > 1444816 kB > 1457488 kB >
    Request #12: 1506592 kB > 1555436 kB > 1604540 kB > 1542700 kB > 1542964 kB > 1542964 kB > 1550356 kB > 1550356 kB > 1549740 kB > 1549740 kB >
    Request #13: 1551448 kB > 1590260 kB > 1601348 kB > 1601348 kB > 1641212 kB > 1644380 kB > 1653356 kB > 1664972 kB > 1669196 kB > 1672628 kB >
    Request #14: 1721732 kB > 1743700 kB > 1699016 kB > 1708760 kB > 1708760 kB > 1708760 kB > 1708760 kB > 1708760 kB > 1708760 kB > 1708760 kB >
    Request #15: 1757864 kB > 1806708 kB > 1855812 kB > 1885644 kB > 1892508 kB > 1892508 kB > 1893300 kB > 1893300 kB > 1893300 kB > 1826224 kB >
    Request #16: 1875328 kB > 1924172 kB > 1960868 kB > 1962716 kB > 1962716 kB > 1962716 kB > 1971344 kB > 1971344 kB > 1986656 kB > 2010152 kB >
    Request #17: 2059256 kB > 2108100 kB > 2157204 kB > 2145724 kB > 2084988 kB > 2109764 kB > 2109764 kB > 2090892 kB > 2090892 kB > 2090892 kB >
    Request #18: 2139996 kB > 2188840 kB > 2231300 kB > 2245820 kB > 2254004 kB > 2254796 kB > 2258228 kB > 2258228 kB > 2258228 kB > 2273540 kB >
    Request #19: 2322644 kB > 2371488 kB > 2420592 kB > 2421796 kB > 2421796 kB > 2337768 kB > 2275480 kB > 2275480 kB > 2246576 kB > 2246576 kB >
    Request #20: 2295680 kB > 2344524 kB > 2393628 kB > 2407356 kB > 2411580 kB > 2414220 kB > 2427948 kB > 2428212 kB > 2428212 kB > 2436132 kB >

## I tried recreate this without puma (just plain ruby threads)

    ruby -r./app.rb -e "20.times { Thread.new { App.call(nil) }.join }"

but without success:

    Initial memory usage: 8680 kB
    Request #1: 57780 kB > 104512 kB > 118240 kB > 139360 kB > 147016 kB > 146344 kB > 146336 kB > 146324 kB > 145392 kB > 145392 kB >
    Request #2: 145400 kB > 145400 kB > 145400 kB > 150940 kB > 150940 kB > 145996 kB > 145996 kB > 145996 kB > 145996 kB > 145996 kB >
    Request #3: 146080 kB > 146064 kB > 146064 kB > 146060 kB > 146060 kB > 146060 kB > 146060 kB > 146060 kB > 146060 kB > 146060 kB >
    Request #4: 149224 kB > 149224 kB > 150016 kB > 150016 kB > 149472 kB > 149472 kB > 146060 kB > 146060 kB > 149224 kB > 153712 kB >
    Request #5: 157484 kB > 157484 kB > 146900 kB > 146060 kB > 146060 kB > 146056 kB > 150540 kB > 154236 kB > 158460 kB > 158460 kB >
    Request #6: 154744 kB > 154744 kB > 146048 kB > 146048 kB > 154756 kB > 155020 kB > 159508 kB > 159508 kB > 159508 kB > 156624 kB >
    Request #7: 157192 kB > 157192 kB > 156792 kB > 156792 kB > 146140 kB > 146036 kB > 146036 kB > 146036 kB > 146036 kB > 146032 kB >
    Request #8: 146032 kB > 146032 kB > 146028 kB > 146028 kB > 146028 kB > 146024 kB > 146024 kB > 146024 kB > 146020 kB > 146020 kB >
    Request #9: 146020 kB > 146016 kB > 146016 kB > 146012 kB > 146012 kB > 146012 kB > 146012 kB > 146008 kB > 146008 kB > 146004 kB >
    Request #10: 146004 kB > 146004 kB > 146004 kB > 146000 kB > 146000 kB > 146000 kB > 146000 kB > 145996 kB > 145996 kB > 145996 kB >
    Request #11: 145996 kB > 145996 kB > 145996 kB > 145988 kB > 145988 kB > 145984 kB > 145972 kB > 145968 kB > 145968 kB > 145968 kB >
    Request #12: 145968 kB > 145968 kB > 145968 kB > 145964 kB > 145964 kB > 145964 kB > 145960 kB > 145960 kB > 145960 kB > 145960 kB >
    Request #13: 145960 kB > 145956 kB > 145956 kB > 145956 kB > 145956 kB > 145956 kB > 145956 kB > 145956 kB > 145956 kB > 145952 kB >
    Request #14: 145952 kB > 145948 kB > 145948 kB > 145944 kB > 145944 kB > 145940 kB > 145936 kB > 145932 kB > 145932 kB > 145924 kB >
    Request #15: 145920 kB > 145916 kB > 145916 kB > 145912 kB > 145912 kB > 145912 kB > 145912 kB > 145912 kB > 145912 kB > 145904 kB >
    Request #16: 145904 kB > 145900 kB > 145900 kB > 145892 kB > 145892 kB > 145888 kB > 145888 kB > 145888 kB > 145888 kB > 145888 kB >
    Request #17: 145888 kB > 145880 kB > 145880 kB > 145880 kB > 145880 kB > 145880 kB > 145848 kB > 145848 kB > 145836 kB > 145836 kB >
    Request #18: 145824 kB > 145628 kB > 145628 kB > 145444 kB > 145444 kB > 145404 kB > 145404 kB > 145400 kB > 145400 kB > 145396 kB >
    Request #19: 145396 kB > 145396 kB > 145396 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB >
    Request #20: 145392 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB > 145392 kB >

## And then I tried to not allow threads die after the job is done:

    ruby -r./app.rb -e "threads = 5.times.map { t = Thread.new { App.call(nil); sleep(100) }; sleep(10); t }.map(&:join); App.call(nil)"

And memory consumption is similar to the puma examples:

    Initial memory usage: 8496 kB
    Request #1: 57596 kB > 105648 kB > 118056 kB > 140232 kB > 147096 kB > 145432 kB > 145424 kB > 145424 kB > 145424 kB > 145424 kB >
    Request #2: 192332 kB > 223488 kB > 238800 kB > 252000 kB > 275760 kB > 274492 kB > 274492 kB > 274492 kB > 274492 kB > 274492 kB >
    Request #3: 323596 kB > 295684 kB > 300964 kB > 300964 kB > 300964 kB > 304396 kB > 312580 kB > 312580 kB > 306544 kB > 306544 kB >
    Request #4: 355648 kB > 399428 kB > 441404 kB > 441404 kB > 444044 kB > 444044 kB > 441724 kB > 441724 kB > 441724 kB > 440992 kB >
    Request #5: 490096 kB > 538608 kB > 587712 kB > 581248 kB > 588372 kB > 585620 kB > 585620 kB > 585620 kB > 585620 kB > 585620 kB >
    Request #6: 634472 kB > 676484 kB > 676612 kB > 667624 kB > 667624 kB > 667624 kB > 667624 kB > 667624 kB > 667624 kB > 667624 kB >

## jruby?

Run server:

    puma -p 3000 -e production -t 20:20

Curl:

    for i in {1..20}; do curl http://localhost:3000; done

Puma output:

    Initial memory usage: 289192 kB
    Request #1: 289856 kB > 331320 kB > 328596 kB > 360592 kB > 362088 kB > 380468 kB > 380900 kB > 391848 kB > 396132 kB > 396356 kB >
    Request #2: 396624 kB > 391836 kB > 391848 kB > 391856 kB > 391864 kB > 391876 kB > 391896 kB > 391896 kB > 391912 kB > 391904 kB >
    Request #3: 392024 kB > 392160 kB > 392164 kB > 392160 kB > 392168 kB > 392212 kB > 392284 kB > 392288 kB > 392296 kB > 392308 kB >
    Request #4: 392320 kB > 392460 kB > 392480 kB > 392480 kB > 392488 kB > 392488 kB > 392492 kB > 392492 kB > 392500 kB > 392512 kB >
    Request #5: 392548 kB > 392672 kB > 392696 kB > 392732 kB > 392744 kB > 392744 kB > 392748 kB > 392748 kB > 392768 kB > 392768 kB >
    Request #6: 392964 kB > 393236 kB > 393416 kB > 393412 kB > 393428 kB > 393440 kB > 393444 kB > 393472 kB > 393488 kB > 393492 kB >
    Request #7: 393544 kB > 393676 kB > 393692 kB > 393700 kB > 393708 kB > 393716 kB > 395764 kB > 395764 kB > 395772 kB > 395776 kB >
    Request #8: 395832 kB > 395972 kB > 395976 kB > 395992 kB > 395984 kB > 395992 kB > 395992 kB > 395996 kB > 395996 kB > 396000 kB >
    Request #9: 396028 kB > 396164 kB > 396168 kB > 396172 kB > 396184 kB > 396180 kB > 396184 kB > 396380 kB > 396380 kB > 396392 kB >
    Request #10: 396516 kB > 396648 kB > 396648 kB > 396652 kB > 396652 kB > 396664 kB > 396660 kB > 396668 kB > 396680 kB > 396684 kB >
    Request #11: 396784 kB > 396784 kB > 396792 kB > 396872 kB > 396880 kB > 397268 kB > 397260 kB > 397264 kB > 397272 kB > 397272 kB >
    Request #12: 397420 kB > 397548 kB > 397548 kB > 397556 kB > 397564 kB > 397936 kB > 397948 kB > 398092 kB > 398092 kB > 398100 kB >
    Request #13: 390996 kB > 391124 kB > 391132 kB > 391136 kB > 391140 kB > 391140 kB > 393388 kB > 393412 kB > 393532 kB > 393576 kB >
    Request #14: 393864 kB > 393996 kB > 394000 kB > 394012 kB > 394032 kB > 394036 kB > 394036 kB > 396084 kB > 396092 kB > 396084 kB >
    Request #15: 396224 kB > 396360 kB > 396360 kB > 396360 kB > 396368 kB > 396368 kB > 396368 kB > 396376 kB > 396380 kB > 396388 kB >
    Request #16: 396496 kB > 396628 kB > 396628 kB > 396640 kB > 396644 kB > 396652 kB > 396656 kB > 396660 kB > 396660 kB > 396672 kB >
    Request #17: 396796 kB > 396936 kB > 396936 kB > 396936 kB > 396944 kB > 396944 kB > 396952 kB > 396960 kB > 396964 kB > 396964 kB >
    Request #18: 397152 kB > 397272 kB > 397272 kB > 397272 kB > 397288 kB > 397292 kB > 397296 kB > 397296 kB > 397300 kB > 397312 kB >
    Request #19: 397468 kB > 397592 kB > 397588 kB > 397588 kB > 397596 kB > 397596 kB > 397600 kB > 397600 kB > 397600 kB > 397600 kB >
    Request #20: 397732 kB > 399924 kB > 399940 kB > 399932 kB > 399936 kB > 399940 kB > 399940 kB > 399944 kB > 399956 kB > 399960 kB >
