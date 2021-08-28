import Foundation
import Combine

// MARK:- 06.Combining Operators
/* description: 여러 Operators 통해 여러 Publisher를 결합할 수 있다.
 - 각 연산자는 새로운 publisher 반환.
 - 연산자를 연결하여 처리 단계를 추가할 수 있다.
*/


//Example 1. CombineLatest : 여러 Publisher의 값 결합
/*
 - 각자 적어도 하나의 값을 전달하기를 기다림.
 - 이후에 클로저를 호출하여 결합된 값을 생성.
 - Publisher가 값을 내보낼 때마다 다시 호출.
*/
debugPrint("===== CombineLatest =====")

//[Simulate] :: textField에 입력을 받아 -> 유효성 검사를 하는 경우 (최신 값을 Combine)
let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

let validateCredentialSubscription = Publishers
    .CombineLatest(usernamePublisher, passwordPublisher)
    .map({ (username, password) -> Bool in
        !(username.isEmpty) && !(password.isEmpty) && password.count > 12
    })
    .sink { valid in
        debugPrint("CombineLatest - is validated? \(valid)")
    }

//[Simulate] :: username과 password를 입력받음
usernamePublisher.send("parktaehwan")
passwordPublisher.send("under12PWD")
passwordPublisher.send("over12PWD!!!!")


//Example 2. Merge : 여러 Publisher의 스트림을 하나로 병합
/*
 - 값의 순서는 결합된 Publisher들의 방출 순서에 따른다.
 - 모든 Publisher들은 같은 타입이어야 한다.
 */
print("\n")
debugPrint("===== Merge =====")

let publisher1 = [1,2,3,4,5].publisher
let publisher2 = [100,200,300].publisher

let mergedPublishersSubscription = Publishers
    .Merge(publisher1, publisher2)
    .sink { value in
        debugPrint("Merge: Subscription received \(value)")
    }
