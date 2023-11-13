import UIKit
import Combine

//CombineLatest
//The same type combine--------------------------------------------------------------------------------------------
//let publisher1 = CurrentValueSubject<Int, Never>(1)
//let publisher2 = CurrentValueSubject<Int, Never>(2)
//
//let combineLatest = publisher1.combineLatest(publisher2)
//
//let cancellable = combineLatest
//    .sink { value1, value2 in
//        print("Value 1 = \(value1) | Value 2 = \(value2)")
//    }
//
//publisher1.send(3)
//publisher2.send(4)
//Difference type combine-------------------------------------------------------------------------------------------
//let publisher1 = CurrentValueSubject<Int, Never>(1)
//let publisher2 = CurrentValueSubject<String, Never>("Hello World")
//
//let combineLatest = publisher1.combineLatest(publisher2)
//
//let cancellable = combineLatest
//    .sink { value1, value2 in
//        print("Value 1 = \(value1) | Value 2 = \(value2)")
//    }
//
//publisher1.send(3)
//publisher2.send("Introduction")

// ZIP------------------------------------------------------------------------------------------

//let indexPublisher = [1, 2, 3].publisher
//let titlePublisher = ["A", "B", "C", "D"].publisher
//let namePublisher = ["Nguyen", "Trung", "Tin"].publisher
//
//let zippedPublisher = Publishers.Zip3(indexPublisher, titlePublisher, namePublisher)
//
//let cancellable = zippedPublisher
//    .sink { value in
//        print("Index: \(value.0)\nTitle: \(value.1)\nName: \(value.2)\n")
//    }

// SwitchToLatest------------------------------------------------------------------------------------------

let outerPublisher = PassthroughSubject<AnyPublisher<Int, Never>, Never>()
let innerPublisher1 = CurrentValueSubject<Int, Never>(1)
let innerPublisher2 = CurrentValueSubject<Int, Never>(2)

let cancellable = outerPublisher
    .switchToLatest()
    .sink { value in
        print(value)
    }

outerPublisher.send(AnyPublisher(Just(10)))
outerPublisher.send(AnyPublisher(innerPublisher1))
innerPublisher1.send(100)

outerPublisher.send(AnyPublisher(innerPublisher2))
innerPublisher2.send(200)
innerPublisher2.send(2000)
