
import UIKit

class GameViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var viewForMarks: UIView!
    @IBOutlet weak var viewForButtons: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    // MARK: - Public properties
    
    var timerForCrash = Timer()
    var timerForAnimateBarrier = Timer()
    var timerForScore = Timer()
    var choosenCar = ""
    var choosenBarrier = ""
    var userName = ""
    var userCount = 0
    var stopAnimationsFlag: Bool = true
    var userData: UserData?
//    var speed = 0.1
    let mainCar = UIImageView()
    let barrier = UIImageView()
    let dateFormatter = DateFormatter()
    
    // MARK: - Lifestyle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MMM d, h:mm a"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        if UserDefaults.standard.value(forKey: "userSettingsKey") != nil {
        if let data = UserDefaults.standard.value(forKey: "userSettingsKey") as? Data {
            do {
                let userSettings = try JSONDecoder().decode(UserData.self, from: data)
                self.userData = userSettings
            } catch {
                print (error)
                userData = UserData(selectedCar: "", selectedObstacle: "", userName: "")
            }
        } else {
            userData = UserData(selectedCar: "", selectedObstacle: "", userName: "")
        }
            choosenCar = self.userData?.selectedCar ?? ""
            choosenBarrier = self.userData?.selectedObstacle ?? ""
            userName = self.userData?.userName ?? ""
            userNameLabel.text = "\(userName)"
        } else {
            userData = UserData(selectedCar: "red_car_image", selectedObstacle: "yellow_car_image", userName: "Player 1")
            choosenCar = self.userData?.selectedCar ?? ""
            choosenBarrier = self.userData?.selectedObstacle ?? ""
            userName = self.userData?.userName ?? ""
            userNameLabel.text = "Player: \(userName)"
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timerForScore) in
            self.userCount += 1
            self.userScoreLabel.text = "Score: \(self.userCount)"
        }
        
        leftButton.layer.cornerRadius = 20
        rightButton.layer.cornerRadius = 20
        leftButton.getShadow()
        rightButton.getShadow()
        
        mainCar.image = UIImage(named: "\(choosenCar)")
        mainCar.frame = CGRect(x: 0, y: 0, width: mainView.frame.width / 4, height: mainView.frame.height / 4)
        mainCar.center = CGPoint(x: mainView.frame.width / 2, y: view.frame.height - mainCar.frame.height - mainCar.frame.height / 2)
        mainView.addSubview(mainCar)
        barrier.image = UIImage(named: "\(choosenBarrier)")
        if choosenBarrier == "yellow_car_image" {
            barrier.frame = CGRect(x: 0, y: 0, width: 95, height: 200)
        } else {
            barrier.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        }
        barrier.center = CGPoint(x: mainView.frame.width / .random(in: 1...3), y: 0)
        mainView.addSubview(barrier)
    
        animateBarrier()
        startTimerForCrash()
        animateRoad()
    }
    
    // MARK: - Flow functions
    
    func crash () {
        if (mainCar.frame.intersects(barrier.frame)) {
            saveRecords()
            stopAnimationsFlag = false
            stopTimerForCrash()
            timerForAnimateBarrier.invalidate()
            timerForScore.invalidate()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let gameOverViewController = storyboard.instantiateViewController(identifier: String (describing: GameOverViewController.self)) as! GameOverViewController
            gameOverViewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(gameOverViewController, animated: true)
        }
    }
    
    func saveRecords() {
        let date = NSDate()
        let dateString = dateFormatter.string(from: date as Date)
        UserDefaults.standard.set("Player: \(userName), Score: \(userCount), Date: \(dateString)", forKey: "userRecordsKey")
    }
    
    func stopTimerForCrash() {
        timerForCrash.invalidate()
    }
    
    func startTimerForCrash() {
        timerForCrash = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timerForCrash) in
            self.crash()
        })
    }
    
    func animateRoad() {
//        speed *= 0.98
        if stopAnimationsFlag == true {
            view.layoutIfNeeded()
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveLinear], animations: {
                self.viewForMarks.frame.origin.y += 80
            }) { (result) in
                if self.viewForMarks.frame.origin.y <= self.view.frame.height {
                    self.animateRoad()
                } else {
                    self.viewForMarks.center = CGPoint (x: self.view.frame.width / 2, y: 0)
                    self.animateRoad()
                }
            }
        } else {
            return
        }
    }
    
    func animateBarrier() {
        if stopAnimationsFlag == true {
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                self.barrier.frame.origin.y += 25
            }) { (result) in
                if self.barrier.frame.origin.y <= self.mainView.frame.height {
                    self.animateBarrier()
                } else {
                    self.barrier.center = CGPoint(x: self.mainView.frame.width / .random(in: 1...4), y: -180)
                    Timer.scheduledTimer(withTimeInterval: .random(in: 1...3), repeats: false) { (timerForAnimateBarrier) in
                        self.animateBarrier()
                    }
                }
            }
        } else {
            return
        }
    }
 
    // MARK: - IBActions
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        if mainCar.frame.origin.x - 20 >= 0 {
            mainCar.frame.origin.x -= 20
        } else {
            stopAnimationsFlag = false
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: String (describing: GameOverViewController.self)) as! GameOverViewController
            viewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        if mainCar.frame.origin.x + mainCar.frame.width + 20 <= view.frame.width {
            mainCar.frame.origin.x += 20
        } else {
            stopAnimationsFlag = false
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: String (describing: GameOverViewController.self)) as! GameOverViewController
            viewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
