import UIKit
import Combine

//Filter------------------------------------------------------------------------------------------------
//let numberPublisher = (1...10).publisher
//
//let oddNumbber = numberPublisher.filter { $0 % 2 != 0 }
//
//let cancellable = oddNumbber.sink { value in
//    print(value)
//}

//CompactMap------------------------------------------------------------------------------------------------
//let stringPublisher = ["1", "2", "3", "4", "A"]
//
//let numberPubliser = stringPublisher.compactMap { Int($0) }
//
//let cancellable = numberPubliser
//    .publisher.sink { number in
//        print(number)
//    }

//Debounce------------------------------------------------------------------------------------------------
let textPublisher = PassthroughSubject<String, Never>()

let debouncePublisher = textPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)

let cancellable = debouncePublisher
    .sink { value in
        print(value)
    }

textPublisher.send("A")
textPublisher.send("B")
textPublisher.send("C")
textPublisher.send("D")
textPublisher.send("E")
textPublisher.send("F")
textPublisher.send("G")
textPublisher.send("H")
