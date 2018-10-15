//
//  Puntos.swift
//  squashApp
//
//  Created by Virtualizacion05 on 10/15/18.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

class Puntos: NSObject {

    var scoreAux=0;
    
    func saveScore()->String{
        scoreAux += 1;
        return String(scoreAux);
    }
    
    func getScore()->Int{
        return scoreAux;
    }
    
    func getDate() ->String{
        var finalDate = "";
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd/MM/yyyy"
        let currentDate = Calendar.current
        let hours = currentDate.component(.hour, from: Date());
        let minutes = currentDate.component(.minute, from: Date());

        finalDate = "\(formatDate.string(from: Date())) \(hours):\(minutes)";
        return finalDate;
    }
    
    func saveGame(_ score: Int, _ date: String){
        var juegosAux = [String]();
        
        if((UserDefaults.standard.array(forKey: "Juegos")) != nil){
        var juegos = UserDefaults.standard.array(forKey: "Juegos")! as! [String];
        if (juegos.count >= 5){
            juegos.remove(at: 4);
            juegos.append("\(score)    \(date)");
            juegosAux = juegos.sorted(){ $0 > $1 }
            UserDefaults.standard.set(juegosAux, forKey: "Juegos");
        }else if (juegos.count == 0){
            juegos.append("\(score)    \(date)");
            UserDefaults.standard.set(juegos, forKey: "Juegos");
        }else{
            juegos.append("\(score)    \(date)");
            juegosAux = juegos.sorted(){ $0 > $1 }
            UserDefaults.standard.set(juegosAux, forKey: "Juegos");
            }
            
        }else{
            juegosAux.append("\(score)    \(date)");
            UserDefaults.standard.set(juegosAux, forKey: "Juegos");
        }
        
    }
    
    func getGame() -> [String]{
        var juegos = [String]()
        if((UserDefaults.standard.array(forKey: "Juegos")) != nil){
            juegos = UserDefaults.standard.array(forKey: "Juegos")! as! [String];
        }else{
            print("No hay juegos que mostrar");
            juegos.append("-");
        }
        return juegos;
    }
    
    func clear(){
        let juegos = [String]();
        UserDefaults.standard.set(juegos, forKey: "Juegos");
    }
    
}
