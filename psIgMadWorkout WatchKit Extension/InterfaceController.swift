//======================================================
import WatchKit
import Foundation
import WatchConnectivity
//======================================================

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    // ------------------------------------
    // MARK: ------ OUTLETS
    @IBOutlet var table: WKInterfaceTable!
    // ------------------------------------
    // MARK: ------ PROPERTIES
    var data: [String : String] = [:]
    var dates: [String] = []
    var workouts: [String] = []
    var session: WCSession!
    // ------------------------------------
    // MARK: ------ SYSTEM FUNCTIONS
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    // ------------------------------------
    override func willActivate() {
        // ----------
        super.willActivate()
        // ----------
        if WCSession.isSupported() {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        // ----------
        userDefaultManager()
        // ----------
        self.dates = Array(data.keys)
        self.workouts = Array(data.values)
        tableRefresh()
    }
    // ------------------------------------
    override func didDeactivate() {
        super.didDeactivate()
    }
    // ------------------------------------
    // MARK: ------ WCSessionDelegate FUNCTIONS
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..code
    }
    // ------------------------------------
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        // ----------
        let value = message["Message"] as? [String :  String]
        // ----------
        DispatchQueue.main.async { () ->  Void in
            self.data = value!
            UserDefaults.standard.set(self.data, forKey: "data")
            self.dates = Array(value!.keys)
            self.workouts = Array(value!.values)
            self.tableRefresh()
        }
        // ----------
    }
    // ------------------------------------
    // MARK: ------ tableView FUNCTIONS
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        self.pushController(withName: "page2", context: ["workout" : workouts[rowIndex]])
    }
    // ------------------------------------
    // MARK: ------ OTHER FUNCTIONS
    // ***** Fonction: tableRefresh
    /*
     *  Fait la mise à jour du tableau
     *
     */
    func tableRefresh() {
        table.setNumberOfRows(data.count, withRowType: "row")
        for index in 0..<table.numberOfRows {
            let row = table.rowController(at: index) as! TableRowController
            row.dates.setText(dates[index])
        }
    }
    // ------------------------------------
    func userDefaultManager() {
        if UserDefaults.standard.object(forKey: "data") == nil {
            UserDefaults.standard.set(data, forKey: "data")
        }
        else {
            data = UserDefaults.standard.object(forKey: "data") as! [String : String]
        }
    }
    // ------------------------------------
}
