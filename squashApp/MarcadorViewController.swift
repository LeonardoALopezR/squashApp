//
//  MarcadorViewController.swift
//  squashApp
//
//  Created by Leo on 10/14/18.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

class MarcadorViewController: UIViewController {
    
    let Score = Puntos();

    @IBOutlet weak var marcador1: UILabel!
    @IBOutlet weak var marcador2: UILabel!
    @IBOutlet weak var marcador3: UILabel!
    @IBOutlet weak var marcador4: UILabel!
    @IBOutlet weak var marcador5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let juegos = Score.getGame();
        
        switch juegos.count {
        case 1:
            marcador1.text = juegos[0];
        case 2:
            marcador1.text = juegos[0];
            marcador2.text = juegos[1];
        case 3:
            marcador1.text = juegos[0];
            marcador2.text = juegos[1];
            marcador3.text = juegos[2];
        case 4:
            marcador1.text = juegos[0];
            marcador2.text = juegos[1];
            marcador3.text = juegos[2];
            marcador4.text = juegos[3];
        case 5:
            marcador1.text = juegos[0];
            marcador2.text = juegos[1];
            marcador3.text = juegos[2];
            marcador4.text = juegos[3];
            marcador5.text = juegos[4];
        default:
            print("Error");
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Limpiar(_ sender: UIButton) {
        Score.clear();
        marcador1.text = "-";
        marcador2.text = "-";
        marcador3.text = "-";
        marcador4.text = "-";
        marcador5.text = "-";
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
