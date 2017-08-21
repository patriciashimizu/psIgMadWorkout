// ============================
import UIKit
// ============================
class InfoView: UIViewController {
    // ============================
    // MARK: ------ OUTLETS
    @IBOutlet weak var infoDateLabel: UILabel!
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var reorderButton: UIButton!
    var theDatabase: [String : [[String : String]]]!
    // ============================
    // MARK: ------ PROPERTIES
    var theWorkout: [String]!
    // ============================
    // MARK: ------ SYSTEM FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.theDatabase = Shared.sharedInstance.getDatabase("db")
        self.infoDateLabel.text = self.getDates()[Shared.sharedInstance.theRow]
        self.theWorkout = self.fillUpWorkoutArray(self.infoDateLabel.text!)
    }
    // ============================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // ============================
    // MARK: ------ BUTTONS
    // EDIT
    // ***** Fonction: reorder
    /*
     *  Permet de réordonner les exercices selon le désire de l’utilisateur
     *
     */
    @IBAction func reorder(_ sender: UIButton) {
        if !self.theTableView.isEditing
        {
            self.theTableView.isEditing = true
            self.reorderButton.setTitle("DONE", for: UIControlState())
        }
        else
        {
            self.theTableView.isEditing = false
            self.reorderButton.setTitle("EDIT", for: UIControlState())
        }
    }
    
    
    // ============================
    // MARK: ------ tableView FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.theTableView.backgroundColor = UIColor.clear
        return self.theWorkout.count
    }
    // ============================
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.textLabel!.font = UIFont(name: "Caviar Dreams", size: 14.0)
        cell.textLabel!.text = self.theWorkout[indexPath.row]
        tableView.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    // ============================
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            self.theWorkout.remove(at: indexPath.row)
            self.deleteFromDatabase(self.infoDateLabel.text!, indexToDelete: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    // ============================
    func tableView(_ tableView: UITableView, canMoveRowAtIndexPath indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    // ============================
    func tableView(_ tableView: UITableView, moveRowAtIndexPath fromIndexPath: IndexPath, toIndexPath: IndexPath) {
        let itemToMove = self.theDatabase[self.infoDateLabel.text!]?[fromIndexPath.row]
        self.theDatabase[self.infoDateLabel.text!]?.remove(at: fromIndexPath.row)
        self.theDatabase[self.infoDateLabel.text!]?.insert(itemToMove!, at: toIndexPath.row)
        Shared.sharedInstance.saveDatabase(self.theDatabase)
    }
    // ============================
    // MARK: ------ OTHER FUNCTIONS
    // ***** Fonction: deleteFromDatabase
    /*
     *  Efface la ligne du tableau (la date et les exercices) dans la base de données
     *
     *  @param theDate: la date à être effacée de la base de données
     *  @param indexToDelete: l'index du tableau
     */
    func deleteFromDatabase(_ theDate: String, indexToDelete: Int) {
        for (a, b) in self.theDatabase
        {
            if a == theDate
            {
                for _ in b
                {
                    self.theDatabase[theDate]?.remove(at: indexToDelete)
                    Shared.sharedInstance.saveDatabase(self.theDatabase)
                    return
                }
            }
        }
    }
    // ============================
    // ***** Fonction: fillUpWorkoutArray
    /*
     *  Rempli le tableau avec les dates et exercices qui sont sauvegardées dans la base de données
     *
     *  @param theDate: la date à être montrée
     *  @return arrToReturn: les exercices de la date
     */
    func fillUpWorkoutArray(_ theDate: String) -> [String] {
        var arrToReturn: [String] = []
        
        for (a, b) in self.theDatabase
        {
            if a == theDate
            {
                for c in b
                {
                    for (d, e) in c
                    {
                        arrToReturn.append("[\(e)] : \(d)")
                    }
                }
            }
        }
        
        return arrToReturn
    }
    // ============================
    // ***** Fonction: getDates
    /*
     *  Efface la ligne sélectionnée par l’utilisateur
     *
     *  @return tempArray: le tableau sans la ligne effacée
     */

    func getDates() -> [String] {
        var tempArray = [""]
        
        for (a, _) in  self.theDatabase
        {
            tempArray.append(a)
        }
        
        tempArray.remove(at: 0)
        
        return tempArray
    }
    // ============================
}
// ============================




















