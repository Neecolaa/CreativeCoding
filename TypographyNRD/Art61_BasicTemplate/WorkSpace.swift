/*
 Assignment: Typography with Objects
 Student: Nicole Dubin
 Pasadena City College, Fall 2019
 Prof. Masood Kamandy
 Project Description: My initials (NRD) drawn using only overlapping, transulcent circles. Now with classes
 Last Modified: October 26, 2019
 */

//  Utilizes the Art61_BasicTemplate
//  Created by MASOOD KAMANDY on 4/30/18.
//  Copyright © 2018 Masood Kamandy. All rights reserved.

import UIKit
import C4

class WorkSpace: CanvasController {
    
    func clearScreen(){
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
    }
    
    override func setup() {
        
        canvas.backgroundColor = black
        let nrd = NRD(canvas: canvas)
        
        let myTimer = C4.Timer(interval: 1.0) {
            self.clearScreen()
            nrd.randomize()
            nrd.draw()
        }
        
        myTimer.start()
    }
}
