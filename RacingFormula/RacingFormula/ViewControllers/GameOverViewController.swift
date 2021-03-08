
import UIKit

class GameOverViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var restartButton: UIButton!
    @IBOutlet weak private var menuButton: UIButton!
    @IBOutlet weak private var records: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var backRestartButtonView: UIImageView!
    @IBOutlet weak private var backMenuButtonView: UIImageView!
    @IBOutlet weak private var visualEffectView: UIVisualEffectView!
    
    // MARK: - Public properties
    
    var userName = ""
    private var userScore = 0
    private var userRecordsDate = ""
    private var lastRecords = ""
    private var recordsArray = [String]()
    
    // MARK: - Lifestyle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        if UserDefaults.standard.value(forKey: "userRecordsKey") != nil {
            records.text = UserDefaults.standard.value(forKey: "userRecordsKey") as? String
        } else {
            return
        }
        imageView.image = UIImage(named: "back_image_4")
        visualEffectView.alpha = 0.5
        lastRecords = records.text ?? ""
        backRestartButtonView.layer.cornerRadius = 10
        backRestartButtonView.alpha = 0.5
        restartButton.layer.cornerRadius = 10
        backMenuButtonView.layer.cornerRadius = 10
        backMenuButtonView.alpha = 0.5
        menuButton.layer.cornerRadius = 10
        saveUserRecord()
    }
    
    //MARK: - Flow functions
    
    func saveUserRecord() {
        if UserDefaults.standard.value(forKey: "lastRecord") != nil {
            recordsArray = UserDefaults.standard.value(forKey: "lastRecord") as? Array ?? []
            let lastUserRecord = lastRecords
            recordsArray.append(lastUserRecord)
            UserDefaults.standard.setValue(recordsArray, forKey: "lastRecord")
        } else {
            recordsArray.append(lastRecords)
            UserDefaults.standard.setValue(self.recordsArray, forKey: "lastRecord")
            return
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func restartBUttonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyboard.instantiateViewController(identifier: String (describing: GameViewController.self)) as! GameViewController
        gameViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: String (describing: ViewController.self)) as! ViewController
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
        viewController.userName = userName
    }

}
