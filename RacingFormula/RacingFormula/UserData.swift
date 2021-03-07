
import UIKit

class UserData: Codable {
    
    var selectedCar: String
    var selectedObstacle: String
    var userName: String

    init (selectedCar: String, selectedObstacle: String, userName: String) {
        self.selectedCar = selectedCar
        self.selectedObstacle = selectedObstacle
        self.userName = userName
}
}
