import Foundation
import Combine

// MARK:- 02.Subjects
/* description: subject는 publisher이다
 - 다른 publishser로 받은 값을 중계한다.
 - 새로운 값을 수동으로 입력할 수 있다.
 - subject는 subscriber이기도 하며 `subscribe(_:)`와 함께 사용할 수 있다.
*/


///Example 1. subscribers에 값을 이어주는 subject
///-> subscribe 하기 전에 send를 하면 전달되지 않는다.
let subject1 = PassthroughSubject<String, Never>()
let subscription1 = subject1.sink { value in
    debugPrint("subscription1이 받은 값: \(value)")
}
subject1.send("Hello")
subject1.send("World")


///Example 2. publisher가 subject를 subscribe
let publisher = ["Park", "Tae", "Hwan"].publisher
publisher.subscribe(subject1)


///Example 3. 'CurrentValueSubject'를 사용하여 최신 값을 유지하고 새로운  subscribers 전달
///-> subscribe 하기 전에 한 send 또한 subscribe 이후에 전달된다.
let subject2 = CurrentValueSubject<String, Never>("")
subject2.send("initial test text")

let subscription2 = subject2.sink { value in
    debugPrint("subscription2이 받은 값: \(value)")
}
subject2.send("more test text")
