
import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var choosenCar: UIImageView!
    @IBOutlet weak private var obstacle: UIImageView!
    @IBOutlet weak private var blackCarButton: UIButton!
    @IBOutlet weak private var redCarButton: UIButton!
    @IBOutlet weak private var orangeCarButton: UIButton!
    @IBOutlet weak private var barrierButton: UIButton!
    @IBOutlet weak private var carButton: UIButton!
    @IBOutlet weak private var stoneButton: UIButton!
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var visualEffectView: UIVisualEffectView!
    @IBOutlet weak private var backViewBackButton: UIView!
    @IBOutlet weak private var backButton: UIButton!
    
    // MARK: - Public properties
    
    var userName = ""
    private var userData: UserData!
    private var selectedCar = "red_car_image"
    private var selectedObstacle = "yellow_car_image"
    private let userCars = ["black_car_image", "red_car_image", "orange_car_image"]
    private let userObstacles = ["barrier_image", "yellow_car_image", "stone_image"]
    
    // MARK: - Lifestyle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        userData = UserData(selectedCar: "", selectedObstacle: "", userName: "Player 1")
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        imageView.image = UIImage(named: "back_image_1")
        visualEffectView.alpha = 0.5
        choosenCar.image = UIImage(named: "red_car_image")
        obstacle.image = UIImage(named: "yellow_car_image")
        
        saveButton.layer.cornerRadius = 10
        saveButton.getShadow()
        blackCarButton.layer.cornerRadius = 5
        blackCarButton.getShadow()
        redCarButton.layer.cornerRadius = 5
        redCarButton.getShadow()
        orangeCarButton.layer.cornerRadius = 5
        orangeCarButton.getShadow()
        barrierButton.layer.cornerRadius = 5
        barrierButton.getShadow()
        carButton.layer.cornerRadius = 5
        carButton.getShadow()
        stoneButton.layer.cornerRadius = 5
        stoneButton.getShadow()
        backViewBackButton.layer.cornerRadius = 10
        backViewBackButton.alpha = 0.5
        
    }
    
    // MARK: - IBActions

    @IBAction func blackCarButtonTapped(_ sender: Any) {
        choosenCar.image = UIImage(named: "black_car_image")
        selectedCar = userCars[0]
    }
    
    @IBAction func redCarButtonTapped(_ sender: Any) {
        choosenCar.image = UIImage(named: "red_car_image")
        selectedCar = userCars[1]
    }
    
    @IBAction func orangeCarButtonTapped(_ sender: Any) {
        choosenCar.image = UIImage(named: "orange_car_image")
        selectedCar = userCars[2]
    }
    
    @IBAction func barrierButtonTapped(_ sender: Any) {
        obstacle.image = UIImage(named: "barrier_image")
        selectedObstacle = userObstacles[0]
    }
    
    @IBAction func carButtonTapped(_ sender: Any) {
        obstacle.image = UIImage(named: "yellow_car_image")
        selectedObstacle = userObstacles[1]
    }
    
    @IBAction func stoneButtonTapped(_ sender: Any) {
        obstacle.image = UIImage(named: "stone_image")
        selectedObstacle = userObstacles[2]
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if nameTextField.text != "" {
            self.userData.userName = nameTextField.text ?? ""
        } else {
            nameTextField.text = "Player 1"
        }
        self.userData.selectedCar = selectedCar
        self.userData.selectedObstacle = selectedObstacle
        
        do {
        let data = try JSONEncoder().encode(userData)
            UserDefaults.standard.setValue(data, forKey: "userSettingsKey")
        } catch {
            print(error)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Flow functions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleKeyboardWillHide () {
        scrollView.contentInset = .zero
    }
    
    @objc func handleKeyboardDidShow (_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let bottomInset = keyboardFrame.height
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
            scrollView.contentInset = insets
        }
    }
    
}

    // MARK: - Extension UITextField

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
