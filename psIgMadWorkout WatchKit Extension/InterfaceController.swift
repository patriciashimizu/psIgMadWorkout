//======================================================
import WatchKit
import Foundation
import WatchConnectivity
//======================================================

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // ------------------------------------
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    // ------------------------------------
    override func willActivate() {
        super.willActivate()
    }
    // ------------------------------------
    override func didDeactivate() {
        super.didDeactivate()
    }
    // ------------------------------------
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..code
    }
    // ------------------------------------
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
    }
    // ------------------------------------

}
