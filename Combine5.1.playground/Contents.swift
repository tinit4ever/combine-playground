import UIKit
import Combine

//PassthroughSubject
//let subject = PassthroughSubject<Int, Never>()
//
//subject.send(2)
//
//let cancellable = subject.sink { value in
//    print(value)
//}
//
//subject.send(3)
//subject.send(99)

// CurrentValueSubject

let subject = CurrentValueSubject<String, Never>("Hello")

subject.send("I'm")

let cancellable = subject
    .sink { value in
        print(value)
    }

subject.send("Tin")

subject.send("How are you today")
