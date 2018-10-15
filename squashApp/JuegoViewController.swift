//
//  JuegoViewController.swift
//  squashApp
//
//  Created by Leo on 10/14/18.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController, UICollisionBehaviorDelegate {
    
    let Score = Puntos();
    var Obs: Obstaculos!;
    
    @IBOutlet weak var marcador: UILabel!
    
    var marcadorAux = 0;
    var animator = UIDynamicAnimator();
    let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0));
    let racquet = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 20.0));
    var trayOriginalCenter: CGPoint!;
    var boundaries = UICollisionBehavior();
    
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
        
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark);
        let blurView = UIVisualEffectView(effect: darkBlur);
        
        blurView.frame = circle.bounds;
        
        circle.addSubview(blurView);
        self.view.addSubview(circle);
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        self.racquet.isUserInteractionEnabled = true
        self.racquet.addGestureRecognizer(panGestureRecognizer);
//        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        self.racquet.addGestureRecognizer(gestureRecognizer)
        
    }
    
//    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
//        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
//
//            let translation = gestureRecognizer.translation(in: self.view)
//            // note: 'view' is optional and need to be unwrapped
//            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
//            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
//        }
//    }
    
    @objc func didPan(sender: UIPanGestureRecognizer) {
//        let location = sender.location(in: view)
//        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = self.racquet.center;
            print("Gesture began")
        } else if sender.state == .changed {
            self.racquet.center = CGPoint(x: trayOriginalCenter.x + translation.x, y: trayOriginalCenter.y + translation.y)
            animator.updateItem(usingCurrentState: racquet);
            print("Gesture is changing")
        } else if sender.state == .ended {
            self.racquet.center = CGPoint(x: trayOriginalCenter.x + translation.x, y: trayOriginalCenter.y + translation.y)
            print("Gesture ended")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animator = UIDynamicAnimator(referenceView: self.view);
        
        boundaries = UICollisionBehavior(items: [circle,racquet]);
        boundaries.translatesReferenceBoundsIntoBoundary = true;
        boundaries.collisionMode = .everything;
        
        boundaries.addBoundary(withIdentifier: "down" as NSString, from: CGPoint(x:0, y:self.view.bounds.maxY), to: CGPoint(x: self.view.bounds.maxX, y:self.view.bounds.maxY))
//        boundaries.addBoundary(withIdentifier: "left" as NSString, from: CGPoint(x: 0, y:0), to: CGPoint(x: 0, y:self.view.bounds.maxY))
//        boundaries.addBoundary(withIdentifier: "right" as NSString, from: CGPoint(x: self.view.bounds.maxX, y:0), to: CGPoint(x: self.view.bounds.maxX, y:self.view.bounds.maxY))
//        boundaries.addBoundary(withIdentifier: "up" as NSString, from: CGPoint(x: 0, y:0), to: CGPoint(x: self.view.bounds.maxX, y:0))
        
        boundaries.collisionDelegate = self;
        
        
        let bounce = UIDynamicItemBehavior(items: [circle]);
        bounce.elasticity = 1.0;
        bounce.resistance = 0.0;
        bounce.friction = 0.0;
        
        
        let racquetMove = UIDynamicItemBehavior(items: [racquet]);
        racquetMove.density = 10000000;
        racquetMove.resistance = 100;
        racquetMove.allowsRotation = false;
        racquetMove.isAnchored = true;
//
        
        let pushBehavior: UIPushBehavior = UIPushBehavior(items:[circle], mode: UIPushBehaviorMode.instantaneous)
        pushBehavior.pushDirection = CGVector(dx: self.view.frame.width, dy: (self.view.frame.height)*(-1.0));
        pushBehavior.magnitude = 0.22;
       
        animator.addBehavior(pushBehavior);
        animator.addBehavior(racquetMove);
        animator.addBehavior(bounce);
        animator.addBehavior(boundaries);
        
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
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor i1: UIDynamicItem, with i2: UIDynamicItem, at p: CGPoint) {
        if (i1.isEqual(circle) && i2.isEqual(racquet)) ||
            (i2.isEqual(racquet) && i1.isEqual(circle)){
            print("Toco");
            marcador.text = Score.saveScore();
            
            let red = CGFloat(arc4random()).truncatingRemainder(dividingBy: 100) / 100;
            let green = CGFloat(arc4random()).truncatingRemainder(dividingBy: 100) / 100;
            let blue = CGFloat(arc4random()).truncatingRemainder(dividingBy: 100) / 100;
            circle.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1);
            
            if (Score.getScore()%10 == 0){
                obs();
            }
        }
    }
    
    func obs(){
        Obs = Obstaculos(View: view);
        
        let ancho = self.view.bounds.size.width - self.Obs.obstaculo.bounds.size.width
        let x = arc4random_uniform(UInt32(ancho))
        let alto = self.view.bounds.maxY - racquet.bounds.maxY;
        let y = arc4random_uniform(UInt32(alto))
        self.Obs.obstaculo.frame.origin = CGPoint(x: Double(x), y: Double(y));
        
        let obsEstatico = UIDynamicItemBehavior(items: [self.Obs.obstaculo]);
//        obsEstatico.isAnchored = true;
        obsEstatico.density = 10000;
        obsEstatico.resistance = 100;
        obsEstatico.allowsRotation = false;

        let obsColision = UICollisionBehavior(items: [self.Obs.obstaculo]);
        obsColision.translatesReferenceBoundsIntoBoundary = true;
         obsColision.collisionMode = .everything;
        obsColision.collisionDelegate = self;
        self.view.addSubview(self.Obs.obstaculo);

        animator.addBehavior(obsEstatico);
        animator.addBehavior(obsColision);
        animator.updateItem(usingCurrentState: self.Obs.obstaculo);
//        self.boundaries.addItem(self.Obs.obstaculo);
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if((identifier) != nil){
            if (String(describing: identifier!) == "down"){
                self.boundaries.removeItem(circle);
                
                Score.saveGame(Score.getScore(), Score.getDate());
                
                let alerta = UIAlertController(title: "¡Game Over!", message: "Tu puntaje es: \(Score.getScore()) \n \(Score.getDate())", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Menú", style: .default) { (action) -> Void in
                    let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "Menu")
                    self.navigationController?.navigationBar.isHidden = false;
                    self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
                }
                    alerta.addAction(action);
                    self.present(alerta, animated: true, completion: nil);
                }else{
                print("ok");
            }
        }else{
            print("nil");
        }
            
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
