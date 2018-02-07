//
//  ViewController.swift
//  XTool
//
//  Created by tpeng on 2018/2/6.
//  Copyright © 2018年 tpeng. All rights reserved.
//

import UIKit
//import NEKit
import NetworkExtension

class ViewController: UIViewController {
    var manager: NETunnelProviderManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100));
        btn.backgroundColor = UIColor.red;
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(click), for: UIControlEvents.touchUpInside)
        
        let bt2 = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 100));
        bt2.backgroundColor = UIColor.green;
        view.addSubview(bt2)
        bt2.addTarget(self, action: #selector(log), for: UIControlEvents.touchUpInside)
        
    }
    
    
    @objc func log() {
        navigationController?.pushViewController(ConnectViewController(), animated: true)
    }
    
    
    
    func connect(){
        print("connect tap")
        if(VpnManager.shared.vpnStatus == .off){
            VpnManager.shared.connect()
        }else{
            VpnManager.shared.disconnect()
        }
    }
    
    
    @objc func click() {
        connect()
    }
    
    
}

