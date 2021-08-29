import Foundation
import Combine
import UIKit

// MARK:- 08.Foundation & Combine
/// description: Foundation은 다음과 같은 다양한 유형에 대해 Combine Publisher를 추가한다.


//Example 1. URLSessionTask publisher와 JSON Decoding operator
struct DecodableExample: Decodable { }

URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.avanderlee.com/feed/")!)
    .map({$0.data})
    .decode(type: DecodableExample.self, decoder: JSONDecoder())


//Example 2. Notification을 위한 Publisher
NotificationCenter.default.publisher(for: .NSSystemClockDidChange)


//Example 3. NSObject 객체에 KeyPath 바인딩
let ageLabel = UILabel()
Just(28)
    .map({"Age is \($0)"})
    .assign(to: \.text, on: ageLabel)


//Example 4. Cocoa 프레임워크의 타이머를 노출시키는 타이머 Publisher
/// - Connectable을 하는 점이 포인트.
/// - autoconnect를 사용하여 subscriber가 subscription을 시작할 때 자동으로 시작됨.
let publisher = Timer
    .publish(every: 1.0, on: .main, in: .common)
    .autoconnect()
