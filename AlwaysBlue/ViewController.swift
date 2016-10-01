//
//  ViewController.swift
//  AlwaysBlue
//
//  Created by Jacob Aronoff on 10/1/16.
//  Copyright © 2016 AlwaysBlue. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet var recordButton: UIButton!
    lazy var motionManager = CMMotionManager()
    let queue = OperationQueue()
    var accel_data:[String] = [String]()
    var gyro_data:[String] = [String]()
    var recording = false
    
    @IBAction func start_stop(_ sender: AnyObject) {
        recording = !recording
        print("------------")
        print(accel_data)
        print("------------")
        print(gyro_data)
        print("------------")
        accel_data = []
        gyro_data = []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.isAccelerometerAvailable{
            motionManager.startAccelerometerUpdates(to: queue, withHandler:
                {data, error in
                    
                    guard let data = data else{
                        return
                    }
                    if self.recording {
                        self.accel_data.append("\(data.acceleration.x),\(data.acceleration.y),\(data.acceleration.z)")
                    }
                }
            )
        } else {
            print("Accelerometer is not available")
        }
        if motionManager.isGyroAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1;
            motionManager.startDeviceMotionUpdates()
            
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: queue, withHandler: { (data, error) in
                guard let data = data else {
                    return
                }
                if self.recording {
                    self.gyro_data.append("\(data.rotationRate.x),\(data.rotationRate.y),\(data.rotationRate.z)")
                }
            })
        } else {
            // alert message
        }
    }

}

