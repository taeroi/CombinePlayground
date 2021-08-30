import Foundation
import Combine
import UIKit

// MARK:- 10.@Publised Properties
/*
 ## ObservableObject
 - `ObservableObject`에서 상속받은 클래스는 자동으로 'Observable'한 것을 합성한다.
 - 클래스의 '@Published' 속성이 변경될 때마다 실행된다.
 */

debugPrint("===== Observable Object =====")

class ObservableFromViewModel: ObservableObject {
    @Published var isSubmitAllowed: Bool = true
    @Published var username: String = ""
    @Published var password: String = ""
    var something: Int = 100
}

var observableFromViewModel = ObservableFromViewModel()

let formSubscription = observableFromViewModel
    .objectWillChange
    .sink { _ in
        debugPrint("Form Changed :: \(observableFromViewModel.isSubmitAllowed), \(observableFromViewModel.username), \(observableFromViewModel.password)")
    }

observableFromViewModel.isSubmitAllowed = false
observableFromViewModel.username = "park"
observableFromViewModel.password = "test"
observableFromViewModel.something = 200
