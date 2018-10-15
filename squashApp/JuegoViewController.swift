//
//  JuegoViewController.swift
//  squashApp
//
//  Created by Leo on 10/14/18.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController {

    var animator: UIDynamicAnimator?;
    let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
    let racquet = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 20.0))
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Do any additional setup after loading the view.
        
        racquet.center = CGPoint(x: (self.view.frame.width)/2, y: (self.view.frame.height)-50);
        racquet.backgroundColor = UIColor.black;
        
        self.view.addSubview(racquet);
        
        circle.center = self.view.center;
        circle.layer.cornerRadius = 10.0;
        circle.backgroundColor = UIColor.black;
        circle.clipsToBounds = true;
        
        
        let darkBlur = UIBlurEffect(style: UIBlurEffect.Style.dark);
        let blurView = UIVisualEffectView(effect: darkBlur);
        
        blurView.frame = circle.bounds;
        
        circle.addSubview(blurView);
        self.view.addSubview(circle);
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animator = UIDynamicAnimator(referenceView: self.view);
        
        let gravity = UIGravityBehavior(items: [circle]);
        let direction = CGVector(dx: 0.0, dy: 1.0);
        gravity.gravityDirection = direction;
        
        let boundaries = UICollisionBehavior(items: [circle, racquet]);
        boundaries.translatesReferenceBoundsIntoBoundary = true;
        
        let bounce = UIDynamicItemBehavior(items: [circle]);
        bounce.elasticity = 2.0;
        bounce.resistance = 1.5;
        
        let racquetMove = UIDynamicItemBehavior(items: [racquet]);
        racquetMove.isAnchored = true;
        
        animator?.addBehavior(racquetMove);
        animator?.addBehavior(bounce);
        animator?.addBehavior(boundaries);
        animator?.addBehavior(gravity);
//        UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: [], animations: ({
//
//            self.circle.center = CGPoint(x: self.view.frame.width, y: 0.0);
//
//            if (self.circle.center == CGPoint(x: self.view.frame.width, y: 0.0)){
//                UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: [], animations: ({
//
//                    self.circle.center = CGPoint(x: -1.0*(self.view.frame.width), y: self.view.frame.height);
//
//                }),completion: nil);
//            }
//
//        }), completion: nil);
        
    }
    
    func comenzar(){
//        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: ({
//
//            self.circle.frame.origin.x += 50;
//
//        }), completion: nil);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
