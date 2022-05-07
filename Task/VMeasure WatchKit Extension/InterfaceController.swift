//
//  InterfaceController.swift
//  VMeasure WatchKit Extension
//
//  Created by Tran Manh Quy on 29/04/2022.
//

import WatchKit
import Foundation
import CoreMotion

enum VelocityVector: Int {
    case x, y, z
}

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var labelVelocity: WKInterfaceLabel!
    let coreMotion = CMMotionManager.init()
    let pool = OperationQueue.init()
    
    override func awake(withContext context: Any?) {
        coreMotion.accelerometerUpdateInterval = 0.1
        coreMotion.startAccelerometerUpdates(to: pool) { data, err in
            guard let _data = data else { return }
            DispatchQueue.main.async {
                self.labelVelocity.setText(String.init(format: "G-Force (x:y:z) %.3f:%.3f:%.3f", arguments: [_data.acceleration.x, _data.acceleration.y, _data.acceleration.z]))
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
