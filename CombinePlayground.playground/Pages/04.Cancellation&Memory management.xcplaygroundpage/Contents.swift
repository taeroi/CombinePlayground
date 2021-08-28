import Foundation
import Combine
import UIKit

// MARK:- 04.Cancellation&Memory management
/* description: Subscription은 Cancellable 객체를 반환한다
 - 'Cancellable'을 사용하여 메모리를 올바르게 관리하면 참조가 유지되지 않는다.
*/


class MyClass {
    var cancellable: Cancellable? = nil
    var variable: Int = 0 {
        didSet {
            debugPrint("MyClass 객체의 variable: \(variable)")
        }
    }
    
    init(subject: PassthroughSubject<Int, Never>) {
        cancellable = subject
            .sink { [weak self] value in
                self?.variable += value
        }
    }
    
    deinit {
        debugPrint("MyClass 객체가 deallocated.")
    }
}


let subject = PassthroughSubject<Int,Never>()
var object: MyClass? = MyClass(subject: subject)

func emitNextValue(from values: [Int], after delay: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        var array = values
        subject.send(array.removeFirst())
        if !array.isEmpty {
            emitNextValue(from: array, after: delay)
        }
    }
}

emitNextValue(from: [1,2,3,4,5,6,7,8], after: 0.5)


DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    debugPrint("Nullify Object")
    
    object = nil
}
