// ============================
import UIKit
// ============================
class Shared: UIViewController {
    // ============================
    // MARK: ------ PROPERTIES
    var theDatabase: [String : [[String : String]]]!
    var savedUserDefault: UserDefaults = UserDefaults.standard
    static let sharedInstance = Shared()
    var theRow: Int!
    // ============================
    // MARK: ------ OTHER FUNCTIONS
    // ***** Fonction: checkForUserDefaultByName
    /*
     *  Fait la vérification si le nom de l’userDefaults est correct
     *
     *  @param theName: le nom de l'userDefaults
     *  @param andUserDefaultObject: l'userDefaults
     *  @return true ou false
     */
    func checkForUserDefaultByName(_ theName: String, andUserDefaultObject: UserDefaults) -> Bool {
        let userDefaultObject = andUserDefaultObject.object(forKey: theName)
        
        if userDefaultObject == nil
        {
            return false
        }
        
        return true
    }
    // ============================
    // ***** Fonction: saveOrLoadUserDefaults
    /*
     *  Fait la vérification si l’userDefaults existe, pour sauvegarder ou télécharger les données
     *
     *  @param name: le nom de l'userDefaults
     */
    func  saveOrLoadUserDefaults(_ name: String) {
        //self.savedUserDefault.removeObjectForKey(name)
        
        if !self.checkForUserDefaultByName(name, andUserDefaultObject: self.savedUserDefault)
        {
            var tempArray = ["" : [["" : ""]]]
            tempArray[""] = nil
            
            self.saveUserDefaultByName(name, andUserDefaultObject: self.savedUserDefault, andSomeValue: tempArray)
        }
        else
        {
            self.theDatabase = self.savedUserDefault.value(forKey: name) as! [String : [[String : String]]]
        }
    }
    // ============================
    func saveUserDefaultByName(_ theName: String, andUserDefaultObject: UserDefaults, andSomeValue: [String : [[String : String]]]) {
        andUserDefaultObject.setValue(andSomeValue, forKey: theName)
    }
    // ============================
    func getDatabase(_ name: String) -> [String : [[String : String]]] {
        return self.savedUserDefault.value(forKey: name) as! [String : [[String : String]]]
    }
    // ============================
    // ***** Fonction: saveDatabase
    /*
     *  Sauvegarde les données dans l’userDefaults
     *
     *  @param valueToSave: les valeurs à être sauvegardés
     */
    func saveDatabase(_ valueToSave: [String : [[String : String]]]) {
        self.savedUserDefault.setValue(valueToSave, forKey: "db")
    }
    // ============================
}







