import Foundation
import Combine
import UIKit

// MARK:- 09.Flatmap & Error types
/*
 ## flatMap
  - 업스트림 publisher로부터 값을 얻을 때마다 새로운 publisher를 제공한다.
  - 값은 모두 단일 스트림으로 동일(평탄)화 된다.
  - 비동기식으로 배열의 내부 배열을 flat하게 하는 Swift의 flatMap과 비슷하다
 
 ## Error Types
  - 'mapError'를 사용하여 실패를 다른 오류 유형으로 매핑할 수 있다.
 */

// 에러타입 정의
enum RequestError: Error {
    case sessionError(error: Error)
}

//request를 트리거하기 위해 'URLPublihser'라는 publisher를 정의함. 이를 통해 URL을 보냄.
let URLPublihser = PassthroughSubject<URL, RequestError>()

//'flatMap'을 사용하여 URL을 요청된 데이터 publihser로 바꿉니다.
let subscription = URLPublihser
    .flatMap { requestUrl in
        URLSession.shared.dataTaskPublisher(for: requestUrl)
            .mapError { error -> RequestError in
                RequestError.sessionError(error: error)
            }
    }
    .assertNoFailure()
    .sink { result in
        debugPrint("Request completed")
        print("")
        debugPrint("response ::", result.response)
        _ = UIImage(data: result.data)
    }

URLPublihser.send(URL(string: "https://httpbin.org/image/jpg")!)
