//======================================================
import WatchKit
import Foundation
//======================================================
class WorkoutController: WKInterfaceController{
    // ------------------------------------
    // MARK: ------ OUTLETS
    @IBOutlet var displayLabel: WKInterfaceLabel!
    // ------------------------------------
    // MARK: ------ SYSTEM FUNCTIONS
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let temp = context as? [String : String]
        displayLabel.setText(temp?["workout"])
    }
    // ------------------------------------
}
//======================================================
