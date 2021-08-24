
/*
  Combine Playground!!
  - Combine is a declarative Swift API for precessing values over time
  " Customize handling of asynchronous events by combining event-processing operators. "
 */

import Foundation
import Combine

// MARK:- 01.Publishers & Subscribers
/* description: publisher와 subscriber의 간단한 동작 원리 */


///Example 1. 한 개의 값만  "publish" 하고 complete
let publisher1 = Just(111)
debugPrint("publisher1: \(publisher1)")

let subscription1 = publisher1.sink { value in
    debugPrint("publisher1으로 부터 받은 값: \(value)")
}


///Example 2. 여러개의 값을 "publish"
let publisher2 = [1,2,3,4,5].publisher
debugPrint("publisher2: \(publisher2)")

let subscription2 = publisher2.sink { value in
    debugPrint("publisher2로 부터 받은 값: \(value)")
}


///Example 3.  객체에 있는 프로퍼티에 publisher 값을 할당
debugPrint("")
class MyClass {
    var property: Int = 0 {
        didSet {
            debugPrint("MyClass 객체의 프로퍼티에 값 할당: \(property)")
        }
    }
}

let myClass = MyClass()
let subscription3 = publisher2.assign(to: \.property, on: myClass)
