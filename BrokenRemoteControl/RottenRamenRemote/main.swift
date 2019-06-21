import Foundation

let rrr = RottenRamenRemote(initialNumber: 100, maximumNumber: 500000)

print(rrr.solve("5457\n3\n6 7 8"))              // 5 54 545 5455 5456 5457
print(rrr.solve("100\n5\n0 1 2 3 4"))           //
print(rrr.solve("500000\n8\n0 2 3 4 6 7 8 9"))  // 5 51 511 5111 51111 511111 511110 511109 511108...
