
import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var recordsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
        
    // MARK: - Public properties
    
    var choosenCar = ""
    var choosenBarrier = ""
    var userName = ""
    var userData: UserData?

    // MARK: - Lifestyle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        gameButton.layer.cornerRadius = 10
        recordsButton.layer.cornerRadius = 10
        settingsButton.layer.cornerRadius = 10
        gameButton.getShadow()
        recordsButton.getShadow()
        settingsButton.getShadow()
    }

    // MARK: - IBActions
    
    @IBAction func gameButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        guard let gameViewController = storyboard.instantiateViewController(identifier: String (describing: GameViewController.self)) as? GameViewController else {return}
        gameViewController.userName = userName
        gameViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @IBAction func recordsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let recordsViewController = storyboard.instantiateViewController(identifier: String (describing: RecordsViewController.self)) as! RecordsViewController
        recordsViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(recordsViewController, animated: true)
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let settingsViewController = storyboard.instantiateViewController(identifier: String (describing: SettingsViewController.self)) as! SettingsViewController
        settingsViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
}
