import Foundation
import Combine

// MARK:- 03.Subscriptions
/* description: subscriber는 한 개의 subscription을 받는다
 - 0개 혹은 여러개의 값이 published 될 수 있다.
 - 적어도 한 개의 {completion, error}가 호출되어야 한다.
 - completion 이후에는 아무것도 전달되지 않는다.
*/

enum ExampleError: Error {
    case somethingError
}

let subject = PassthroughSubject<String, ExampleError>()

// Subscription lifecycle의 단계
subject.handleEvents { _ in
    debugPrint("새로운 subscription!")
} receiveOutput: { _ in
    debugPrint("output 받음")
} receiveCompletion: { _ in
    debugPrint("subscription 완료")
} receiveCancel: {
    debugPrint("subscription 종료")
}
.replaceError(with: "error")
.sink { value in
    debugPrint("Subscriber가 받은 값: \(value)")
}

subject.send("111")
subject.send("222")
subject.send("333")
subject.send(completion: .failure(.somethingError))
subject.send("444")
subject.send("555")
