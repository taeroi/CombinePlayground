import Foundation
import Combine

// MARK:- 07.Scheduling
/* description:
 - Combine은 'Scheduler' protocol을 도입했다.
 - 'DispatchQueue', 'RunLoop' 등에서 채택한다.
 - Subscription 및 값 전달을 위한 실행 컨텍스트를 결정할 수 있다.
*/

let firstStepDone = DispatchSemaphore(value: 0)

//receive(on:) :: 다음 연산자가 수신할 스케줄러 값을 결정한 다음 'DispatchQueue'와 함께 사용하여 전달되는 대기열 값을 제어할 수 있다.
debugPrint("===== receive(on:) =====")

let publisher = PassthroughSubject<String, Never>()
let receivingQueue = DispatchQueue(label: "receiving-queue")
let subscription = publisher
    .receive(on: receivingQueue)
    .sink { value in
        debugPrint("Received value: \(value) on thread - \(Thread.current) ")
        if value == "Four" {
            firstStepDone.signal()
            debugPrint("First Step Done")
        }
    }

for string in ["One", "Two", "Three", "Four"] {
    DispatchQueue.global().async {
        publisher.send(string)
    }
}

firstStepDone.wait()


print("")
/* subscribe(on:)
 - Subscription이 발생하는 스케줄러를 결정한다.
 - 작업을 시작하는 스케줄러를 제어하는데 유용하다.
 - 값이 전달되는 대기열에 영향을 줄 수도 있고 영향을 미치지 않을 수도 있다.
*/
debugPrint("===== subscribe(on:) =====")

let subscription2 = [1,2,3,4,5].publisher
    .subscribe(on: DispatchQueue.global())
    .handleEvents(receiveOutput: { value in
        debugPrint("Value - \(value) emitted on thread - \(Thread.current)")
    })
    .receive(on: receivingQueue)
    .sink { value in
        debugPrint("Received value - \(value) on thread - \(Thread.current)")
    }
