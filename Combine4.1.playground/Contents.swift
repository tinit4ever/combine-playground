import UIKit
import Combine
//Map------------------------------------------------------------------------------
//let numberPublisher = [1, 2, 3, 4, 5].publisher
//
//let squareNumber = numberPublisher.map { "Square of \($0) is \($0 * $0)"}
//
//let cancelable = squareNumber.sink { value in
//    print(value)
//}

//FlatMap------------------------------------------------------------------------------

//let namePublisher = ["Nguyen", "Trung", "Tin"].publisher
//
//let flattedNamePublisher = namePublisher.flatMap { $0.publisher }
//
//let cancellable = flattedNamePublisher
//    .sink { char in
//        print(char)
//    }

//let mappedNamePublisher = namePublisher.map { $0 }
//
//let cancellable = mappedNamePublisher
//    .sink { name in
//        print(name)
//    }

//Merge (Emmited must be the same type)-----------------------------------------------------------------------

let publisher1 = [1, 2, 3].publisher
let publisher2 = [4, 5, 6].publisher
let publisher3 = [7, 8, 9].publisher

let mergePublisher = Publishers.Merge(publisher1, publisher2)
let superMergePublisher = Publishers.Merge(mergePublisher, publisher3)

let cancellable = superMergePublisher
    .sink { value in
        print(value)
    }
