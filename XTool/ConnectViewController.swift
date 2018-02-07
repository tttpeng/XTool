//
//  ConnectViewController.swift
//  XTool
//
//  Created by tpeng on 2018/2/7.
//  Copyright © 2018年 tpeng. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {

    

    
    let ptManager = PTManager.instance

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white;
        
        ptManager.delegate = self;
        ptManager.connect(portNumber: 4986)
        
        UIApplication.shared.beginBackgroundTask {
            if #available(iOS 10.0, *) {

            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.ptManager.sendObject(object: 100, type: PTType.number.rawValue)
            }
            }
        };
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.ptManager.sendObject(object: 100, type: PTType.number.rawValue)
            }
        } else {
        }
    }



}
extension ConnectViewController: PTManagerDelegate {
    
    func peertalk(shouldAcceptDataOfType type: UInt32) -> Bool {
        return true
    }
    
    func peertalk(didReceiveData data: Data, ofType type: UInt32) {
        if type == PTType.number.rawValue {
            let count = data.convert() as! Int
            print(count)
        } else if type == PTType.image.rawValue {
            let image = UIImage(data: data)
        } else if type == PTType.string.rawValue {
            print(data.convert())
            print("connect tap")
            if(VpnManager.shared.vpnStatus == .off){
                VpnManager.shared.connect()
            }else{
                VpnManager.shared.disconnect()
            }
        }
    }
    
    func peertalk(didChangeConnection connected: Bool) {
        print("Connection: \(connected)")
    }
    
}
