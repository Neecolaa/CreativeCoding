/*
 Assignment: Drawing with Code
 Student: Nicole Dubin
 Pasadena City College, Fall 2019
 Prof. Masood Kamandy
 Project Description: A grid of (randomly sized) circles with panning gesture recognition.
 Last Modified: September 18, 2019
 */

//  Utilizes the Art61_BasicTemplate
//  Created by MASOOD KAMANDY on 4/30/18.
//  Copyright © 2018 Masood Kamandy. All rights reserved.

import UIKit
import C4

class WorkSpace: CanvasController {
    
    override func setup() {
        
        let medGreen = Color(0x02C39A)
        let darkGreen = Color(0x00A896)
        let medCyan = Color(0x028090)
        let darkCyan = Color(0x05668D)
        
        canvas.backgroundColor = darkCyan
        
        let r = Int(canvas.width/12)
        let c = Int(canvas.height/12)
        
        var grid = Array(repeating: Array(repeating: Circle(center: Point(), radius: 0.0), count: c), count: r)
        
        for i in (0..<r) {
            for j in (0..<c) {
                var rad = Double.random(in: 0 ..< 6)//random size of circle
                var x = (i * 12)+6
                var y = (j * 12)+6
                var circ = Circle(center: Point(x,y), radius: rad)
                circ.fillColor = medCyan
                circ.strokeColor = darkGreen
                
                grid[i][j] = circ
                canvas.add(grid[i][j])
            }
        }
        

        canvas.addPanGestureRecognizer { locations, center, translation,
            velocity, state in
            //locate which circle/cell is being touched
            var row = Int(center.x/12)
            var col = Int(center.y/12)
            if(col < c && row < r)//touch is within grid
            {
                var circ = grid[row][col]
                //change color of circle
                circ.fillColor = darkGreen
                circ.strokeColor = medGreen
                
            }
            if (state == .ended) {
                for i in (0..<r) {
                    for j in (0..<c) {
                        //change all circles back to "untouched" state
                        var circ = grid[i][j]
                        circ.fillColor = medCyan
                        circ.strokeColor = darkGreen
                    }
                }
            }
            
        }
        
    }
    
    
}
