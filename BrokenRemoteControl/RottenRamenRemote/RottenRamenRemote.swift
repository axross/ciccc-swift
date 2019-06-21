import Foundation

class RottenRamenRemote {
    private let initialNumber: Int

    private let maximumDigits: Int
    
    private var availableNumbers: [Int]
    
    init(initialNumber: Int, maximumNumber: Int) {
        self.initialNumber = initialNumber
        self.maximumDigits = String(maximumNumber).count
        self.availableNumbers = []
    }
    
    func solve(_ input: String) -> String {
        let (targetNumber, availableNumbers) = self.parseInput(input)
        
        if (targetNumber == self.initialNumber) {
            return "0"
        }
        
        self.availableNumbers = availableNumbers
        
        var numbers: [Int] = []
        
        self.searchPossibleNumbersRecursively(number: 0, foundNumbers: &numbers)

        if var closestNumber = numbers.first {
            for number in numbers {
                let currentClosestdistance = abs(closestNumber - targetNumber) + String(closestNumber).count
                let distance = abs(number - targetNumber) + String(number).count
                
                if distance < currentClosestdistance {
                    closestNumber = number
                }
            }
            
            return String(String(closestNumber).count + abs(targetNumber - closestNumber))
        }
        
        return ""
    }
    
    private func parseInput(_ input: String) -> (Int, [Int]) {
        let inputLines = input.split(separator: "\n")
        let targetNumber = Int(inputLines[0])!
        let unavailableNumberCount = Int(inputLines[1])!
        let unavailableNumbers = inputLines[2].split(separator: " ")[..<unavailableNumberCount].map({ Int($0)! })
        let availableNumbers = numbersOnRemoteControl.filter({ !unavailableNumbers.contains($0) })
        
        return (targetNumber, availableNumbers)
    }
    
    private func searchPossibleNumbersRecursively(number: Int, foundNumbers: inout [Int]) -> Void {
        for availableNumber in self.availableNumbers {
            let nextNumber = Int(String(number) + String(availableNumber))!;
            
            if (nextNumber == 0) {
                continue
            }
            
            foundNumbers.append(nextNumber)
            
            if String(nextNumber).count < self.maximumDigits {
                searchPossibleNumbersRecursively(
                    number: nextNumber,
                    foundNumbers: &foundNumbers
                )
            }
        }
    }
}

let numbersOnRemoteControl = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
