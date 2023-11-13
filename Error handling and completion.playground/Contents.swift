import UIKit
import Combine
//V1---------------------------------------------------------------------------
//enum NumberError: Error {
//    case operationFailed
//}
//
//let numberPublisher = [1, 2, 3, 4, 5].publisher
//
//let doubleNumberPublisher = numberPublisher
//    .tryMap { number in
//        if number == 4 {
//            throw NumberError.operationFailed
//        }
//        
//        return number * 2
//    }
//    .catch { error in
//        if let numberError = error as? NumberError {
//            print("Error occured: \(numberError)")
//        }
//        
//        return Just(0)
//    }
//
//let cancecllabel = doubleNumberPublisher.sink { completion in
//    switch completion {
//    case .finished:
//        print("FINISHED")
//    case .failure(let error):
//        print(error)
//    }
//} receiveValue: { value in
//    print(value)
//}

//V2---------------------------------------------------------------------------
enum NumberError: Error {
    case operationFailed
}

let numberPublisher = [1, 2, 3, 4, 5].publisher

let doubleNumberPublisher = numberPublisher
    .tryMap { number in
        if number == 4 {
            throw NumberError.operationFailed
        }
        
        return number * number
    }
    .mapError { error in
        NumberError.operationFailed
    }

let cancellable = doubleNumberPublisher.sink { completion in
    switch completion {
    case .finished:
        print("FINISHED")
    case .failure(let error):
        print(error)
    }
} receiveValue: { value in
    print(value)
}

