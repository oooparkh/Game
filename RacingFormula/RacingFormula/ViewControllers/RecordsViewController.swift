
import UIKit

class RecordsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var recordsLabel: UILabel!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backDeleteButtonView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    
    // MARK: - Public properties
    
    var array = UserDefaults.standard.object(forKey: "lastRecord") as? [String] ?? [String]()
    var recordsArray = [String]()
    
    // MARK: - Lifestyle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        backButtonView.layer.cornerRadius = 10
        backButtonView.alpha = 0.5
        backDeleteButtonView.layer.cornerRadius = 10
        backDeleteButtonView.alpha = 0.5
        imageView.image = UIImage(named: "back_image_2")
        visualEffectView.alpha = 0.5
    }
   
    // MARK: - IBActions
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        
        if UserDefaults.standard.value(forKey: "lastRecord") != nil {
            recordsArray = UserDefaults.standard.value(forKey: "lastRecord") as? Array ?? []
            recordsArray.removeAll()
            array = recordsArray
            UserDefaults.standard.setValue(recordsArray, forKey: "lastRecord")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

    // MARK: - Extension UITableView

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
}

