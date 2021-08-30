import Foundation
import Combine
import UIKit

// MARK:- 11.Future & Promises
/*
 - 'Future'는 정확히 하나의 값(또는 오류)을 전달하고 complete 됨.
 - 클로저 콜백을 사용하는 컨텍스트에서 유용하고 경량화된 publisher이다.
 - 사용자 정의 메서드를 호출하고 Result.success 또는 Result.failure를 반환할 수 있다.
 */


struct User {
    let id: Int
    let name: String
}

let users = [User(id: 0, name: "Park"),
             User(id: 1, name: "Kim"),
             User(id: 2, name: "Lee") ]

enum FetchError: Error {
    case userNotFound
}

func fetchUser(for userId: Int, completion: (_ result: Result<User, FetchError>) -> Void) {
    if let user = users.first(where: { $0.id == userId }) {
        completion(Result.success(user))
    } else {
        completion(Result.failure(FetchError.userNotFound))
    }
}


let fetchUserPublihser = PassthroughSubject<Int, FetchError>()

fetchUserPublihser
    .flatMap { userId -> Future<User, FetchError> in
        Future { promise in
            fetchUser(for: userId) { result in
                switch result {
                case .success(let user):
                    promise(.success(user))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    .map { user in user.name}
    .catch { (error) -> Just<String> in
        debugPrint("Error Occurred: \(error)")
        return Just("Not Found")
    }
    .sink { result in
        debugPrint("User is \(result)")
    }

fetchUserPublihser.send(0)
fetchUserPublihser.send(100)
