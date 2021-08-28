import Foundation
import Combine

// MARK:- 05.Simple Operators
/* description: Publisher 인스턴스에 정의된 기능
 - 각 연산자는 새로운 publisher 반환.
 - 연산자를 연결하여 처리 단계를 추가할 수 있다.
*/


///Example 1. map
///Swift의 map과 같은 기능으로 동작
let publisher1 =  PassthroughSubject<Int, Never>()

let publisher2 = publisher1.map({ value in
    value + 100
})

let subscription1 = publisher1
    .sink { value in
        debugPrint("subscription1 received: \(value)")
    }

let subscription2 = publisher2
    .sink { value in
        debugPrint("subscription2 received: \(value)")
    }

debugPrint("===== map operator =====")
debugPrint("-----publisher1 emits 100-----")
publisher1.send(100)

debugPrint("-----publisher2 emits 1000-----")
publisher1.send(1000)

subscription1.cancel()
subscription2.cancel()


///Example 2. filter
///Swift의 filter와 같은 기능으로 동작
let publisher3 = publisher1.filter({
    $0 % 2 == 0
})

let subscription3 = publisher3
    .sink { value in
        debugPrint("subscription3 received: \(value)")
    }

print("\n")
debugPrint("===== filter operator =====")
debugPrint("-----publisher3 emits 1-----")
publisher1.send(1)

debugPrint("-----publisher3 emits 2-----")
publisher1.send(2)

debugPrint("-----publisher3 emits 3-----")
publisher1.send(3)

subscription3.cancel()

