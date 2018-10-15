//
//  Obstaculos.swift
//  squashApp
//
//  Created by Virtualizacion05 on 10/15/18.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

class Obstaculos: NSObject {
    
    var obstaculo = UIView();
    var obstaculos = 0;
    var NumeroDeObstaculo = 0;
    
    init(View: UIView){
        
     NumeroDeObstaculo = Int(arc4random_uniform(3))
        
        if(NumeroDeObstaculo == 0){
            
            obstaculo = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50, height: 30))
            obstaculo.backgroundColor = UIColor.red;
            
        }
            
        else if(NumeroDeObstaculo == 1){
            obstaculo = UIView(frame: CGRect(x: View.center.x, y: View.center.y, width: 30, height: 30))
            obstaculo.backgroundColor = UIColor.green;
            
        }
            
        else if(NumeroDeObstaculo == 2){
            obstaculo = UIView(frame: CGRect(x: View.center.x, y: View.center.y, width: 45, height: 30))
            obstaculo.backgroundColor = UIColor.blue;
            
        }
//        obstaculo.clipsToBounds = true
        
    }
    
}
