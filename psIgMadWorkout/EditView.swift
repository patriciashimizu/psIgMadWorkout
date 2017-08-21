// ============================
import UIKit
import Foundation
// ============================
class EditView: UIViewController, UITextFieldDelegate {
    // ============================
    // MARK: ------ OUTLETS
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var addExerciseField: UITextField!
    // ============================
    // MARK: ------ PROPERTIES
    var exerciseAccount: UserDefaults = UserDefaults.standard
    var exerciseAccountability: [String : Int]!
    // ============================
    // MARK: ------ SYSTEM FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseAccountability = self.exerciseAccount.value(forKey: "exercises") as! [String : Int]
        self.addExerciseField.delegate = self
    }
    // ============================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // ============================
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show keyboard by default
        self.addExerciseField.becomeFirstResponder()
    }
    // ============================
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // ============================
    // MARK: ------ BUTTONS
    @IBAction func addExerciseButton(_ sender: UIButton) {
        if self.addExerciseField.text != ""
        {
            self.exerciseAccountability[self.addExerciseField.text!] = 0
            self.exerciseAccount.setValue(self.exerciseAccountability, forKey: "exercises")
            self.addExerciseField.text = ""
            self.theTableView.reloadData()
            self.mAlterts("Exercise Added!")
        }
    }
    // ============================
    // MARK: ------ tableView FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.theTableView.backgroundColor = UIColor.clear
        return self.exerciseAccountability.count
    }
    //-------------
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let intIndex = indexPath.row
        let index = self.exerciseAccountability.index(self.exerciseAccountability.startIndex, offsetBy: intIndex)
        
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.textLabel!.font = UIFont(name: "Caviar Dreams", size: 18.0)
        cell.textLabel!.text = self.exerciseAccountability.keys[index]
        tableView.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    //-------------
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let intIndex = indexPath.row
            let index = self.exerciseAccountability.index(self.exerciseAccountability.startIndex, offsetBy: intIndex)
            self.exerciseAccountability[self.exerciseAccountability.keys[index]] = nil
            self.exerciseAccount.setValue(self.exerciseAccountability, forKey: "exercises")
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //-------------
    // MARK: ------ OTHER FUNCTIONS
    // ***** Fonction: mAlerts
    /*
     *  Montre un message que l’exercice a été ajouté
     *
     *  @param theMessage: le message à être montré
     */
    func mAlterts(_ theMessage: String) {
        let alertController = UIAlertController(title: "Message...", message:
            theMessage, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    //-------------
}
// ============================
