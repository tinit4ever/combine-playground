import UIKit
import Combine

//Catch Error Using ".catch"------------------------------------------------------------------------

enum SampleError: Error {
    case operationFail
}

//let numberPublisher = [1, 2, 3, 4, 5].publisher
//
//let squareNumberPublisher = numberPublisher
//    .tryMap { number in
//        if number == 4 {
//            throw SampleError.operationFail
//        }
//
//        return number * number
//    }.catch { error in
//        print("Error")
//        return Just(0)
//    }
//
//let cancellable = squareNumberPublisher.sink { completion in
//    switch completion {
//    case .finished:
//        print("FINISHED")
//    case .failure(let error):
//        print(error)
//    }
//} receiveValue: { value in
//    print(value)
//}

//Catch Error Using ".replaceError" replace error with single value------------------------------------------
//let numberPublisher = [1, 2, 3, 4, 5].publisher
//
//let squareNumberPublisher = numberPublisher
//    .tryMap { number in
//        if number == 3 {
//            throw SampleError.operationFail
//        }
//
//        return number * number
//    }.replaceError(with: -1)
//
//let cancellable = squareNumberPublisher.sink { completion in
//    switch completion {
//    case .finished:
//        print("FINISHED")
//    case .failure(let error):
//        print(error)
//    }
//} receiveValue: { value in
//    print(value)
//}

//let cancellabel = squareNumberPublisher.sink { result in
//    print(result)
//}
//Catch Error Using ".replaceError" replace error with another publisher----------------------------------
//let numberPublisher = [1, 2, 3, 4, 5].publisher
//
//let fallBackPublisher = Just(-1)
//
//let squareNumberPublisher = numberPublisher
//    .tryMap { number in
//        if number == 4 {
//            throw SampleError.operationFail
//        }
//        
//        return Just(number * number)
//    }.replaceError(with: fallBackPublisher)
//
//let cancellable = squareNumberPublisher
//    .sink { publisher in
//        let _ = publisher.sink { value in
//            print(value)
//        }
//    }

//Retry publisher----------------------------------

let publisher = PassthroughSubject<Int, Error>()

let retriedPublisher = publisher
    .tryMap { value in
        if value == 3 {
            throw SampleError.operationFail
        }
        
        return value
    }.retry(2)

let cancellable = retriedPublisher
    .sink { completion in
        switch completion {
        case .finished:
            print("Finished")
        case .failure(let error):
            print("Error \(error)")
        }
    } receiveValue: { value in
        print(value)
    }

publisher.send(1)
publisher.send(2)
publisher.send(3)
publisher.send(4)
publisher.send(5)
publisher.send(3)
publisher.send(6)
publisher.send(3)
publisher.send(7)
