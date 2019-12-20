/*
Assignment: Drawing with Code
Student: Nicole Dubin
Pasadena City College, Fall 2019
Prof. Masood Kamandy
Project Description: This program is a recreation of
the painting "Endeavor" with code.
 
 Added interactivity:
 1. Clicking any of the 4 squares in the bottom right will cause them all to rotate 90cw
 2. Navy line in upper right corner is draggable
 3. line bisecting rectangles D2 (black & gold) and E2 (white & yellow) is draggable. Colors follow line
 
Last Modified: September 21, 2019
 */

//  Utilizes the Art61_BasicTemplate
//  Created by MASOOD KAMANDY on 4/30/18.
//  Copyright © 2018 Masood Kamandy. All rights reserved.

//Best viewed on an iPhone 7 or similar screen, but fills screen up to iPhone XR

import UIKit
import C4

class WorkSpace: CanvasController {
    
    override func setup() {
        //color palette
        let lightBlue = Color(0xFF9ED9DD)
        let medBlue = Color(0xFF19C1E8)
        let navy = Color(0xFF34336D)
        let gold = Color(0xFFFECF05)
        let yellow = Color(0xFFFFFF33)
        let orange = Color(0xFFF57921)
        let sand = Color(0xFFCC9966)
        let lightGray = Color(0xFFCCCCCC)
        
        canvas.backgroundColor = lightBlue
        
        let rectA1 = Rectangle(frame: Rect(-20, -20, 150, 125))
        rectA1.lineWidth = 20
        rectA1.fillColor = white
        rectA1.strokeColor = lightBlue
        rectA1.lineCap = .square
        rectA1.lineJoin = .miter
        
        let rectA2 = Rectangle(frame: Rect(rectA1.width-20, -20, 225, rectA1.height))
        rectA2.lineWidth = 20
        rectA2.fillColor = black
        rectA2.strokeColor = lightBlue
        rectA2.lineCap = .square
        rectA2.lineJoin = .miter
        
        let rectA3 = Rectangle(frame: Rect(330, -20, rectA1.height, rectA1.height))
        rectA3.lineWidth = 20
        rectA3.fillColor = gold
        rectA3.strokeColor = lightBlue
        rectA3.lineCap = .square
        rectA3.lineJoin = .miter
        
        let rectB1 = Rectangle(frame: Rect(-20, rectA1.height-20, 100, rectA1.height/2))
        rectB1.lineWidth = 20
        rectB1.fillColor = navy
        rectB1.strokeColor = lightBlue
        rectB1.lineCap = .square
        rectB1.lineJoin = .miter
        
        let rectB2 = Rectangle(frame: Rect(rectB1.width-20, rectA1.height-20, rectA1.width - rectB1.width, rectB1.height))
        rectB2.lineWidth = 20
        rectB2.fillColor = gray
        rectB2.strokeColor = lightBlue
        rectB2.lineCap = .square
        rectB2.lineJoin = .miter
        
        let rectB3 = Rectangle(frame: Rect(rectA1.width-20, rectA1.height-20, 500, rectB2.height))
        rectB3.lineWidth = 20
        rectB3.fillColor = black
        rectB3.strokeColor = lightBlue
        rectB3.lineCap = .square
        rectB3.lineJoin = .miter
        
        let rectC1 = Rectangle(frame: Rect(rectB1.frame.origin.x,rectB1.frame.max.y,  rectB1.width, 27))
        rectC1.lineWidth = 20
        rectC1.fillColor = black
        rectC1.strokeColor = lightBlue
        rectC1.lineCap = .square
        rectC1.lineJoin = .miter
        
        let rectC2 = Rectangle(frame: Rect(rectB1.frame.max.x,rectB1.frame.max.y,  600, rectC1.height))
        rectC2.lineWidth = 20
        rectC2.fillColor = black
        rectC2.strokeColor = lightBlue
        rectC2.lineCap = .square
        rectC2.lineJoin = .miter
        
        let rectD1 = Rectangle(frame: Rect(rectC1.frame.origin.x,rectC1.frame.max.y,  rectC1.width, rectB3.height+25))
        rectD1.lineWidth = 20
        rectD1.fillColor = lightGray
        rectD1.strokeColor = lightBlue
        rectD1.lineCap = .square
        rectD1.lineJoin = .miter
        
        let rectD2 = Rectangle(frame: Rect(rectC1.frame.max.x,rectC1.frame.max.y,  300, rectD1.height))
        rectD2.lineWidth = 20
        rectD2.fillColor = gold
        rectD2.strokeColor = lightBlue
        rectD2.lineCap = .square
        rectD2.lineJoin = .miter
        
        let rectD3 = Rectangle(frame: Rect(rectD2.frame.max.x,rectD2.frame.origin.y,  50, rectD2.height))
        rectD3.lineWidth = 20
        rectD3.fillColor = black
        rectD3.strokeColor = lightBlue
        rectD3.lineCap = .square
        rectD3.lineJoin = .miter
        
        let rectE1 = Rectangle(frame: Rect(rectD1.frame.origin.x,rectD1.frame.max.y,  rectD1.width, rectD1.height-5))
        rectE1.lineWidth = 20
        rectE1.fillColor = gray
        rectE1.strokeColor = lightBlue
        rectE1.lineCap = .square
        rectE1.lineJoin = .miter
        
        let rectE2 = Rectangle(frame: Rect(rectD1.frame.max.x,rectD1.frame.max.y,  300, rectE1.height))
        rectE2.lineWidth = 20
        rectE2.fillColor = yellow
        rectE2.strokeColor = lightBlue
        rectE2.lineCap = .square
        rectE2.lineJoin = .miter
        
        let rectE3 = Rectangle(frame: Rect(rectE2.frame.max.x,rectE2.frame.origin.y,  50, rectE2.height))
        rectE3.lineWidth = 20
        rectE3.fillColor = black
        rectE3.strokeColor = lightBlue
        rectE3.lineCap = .square
        rectE3.lineJoin = .miter
        
        let rectF1 = Rectangle(frame: Rect(rectE1.frame.origin.x,rectE1.frame.max.y,  rectE1.width, rectE1.height-15))
        rectF1.lineWidth = 20
        rectF1.fillColor = gray
        rectF1.strokeColor = lightBlue
        rectF1.lineCap = .square
        rectF1.lineJoin = .miter
        
        let rectF2 = Rectangle(frame: Rect(rectE1.frame.max.x,rectE1.frame.max.y,  200, rectF1.height))
        rectF2.lineWidth = 20
        rectF2.fillColor = black
        rectF2.strokeColor = lightBlue
        rectF2.lineCap = .square
        rectF2.lineJoin = .miter
        
        let rectF3 = Rectangle(frame: Rect(rectF2.frame.max.x,rectF2.frame.origin.y,  100, rectF2.height))
        rectF3.lineWidth = 20
        rectF3.fillColor = black
        rectF3.strokeColor = lightBlue
        rectF3.lineCap = .square
        rectF3.lineJoin = .miter
        
        let rectF4 = Rectangle(frame: Rect(rectF3.frame.max.x,rectF3.frame.origin.y,  50, rectF3.height))
        rectF4.lineWidth = 20
        rectF4.fillColor = black
        rectF4.strokeColor = lightBlue
        rectF4.lineCap = .square
        rectF4.lineJoin = .miter
        
        let rectG1 = Rectangle(frame: Rect(rectF1.frame.origin.x,rectF1.frame.max.y,  rectF1.width, rectF1.width))
        rectG1.lineWidth = 20
        rectG1.fillColor = orange
        rectG1.strokeColor = lightBlue
        rectG1.lineCap = .square
        rectG1.lineJoin = .miter
        
        let rectG2 = Rectangle(frame: Rect(rectF1.frame.max.x,rectF1.frame.max.y, rectF2.width, rectG1.height))
        rectG2.lineWidth = 20
        rectG2.fillColor = white
        rectG2.strokeColor = lightBlue
        rectG2.lineCap = .square
        rectG2.lineJoin = .miter
        
        let rectG3 = Rectangle(frame: Rect(rectG2.frame.max.x,rectG2.frame.origin.y,  rectF3.width, rectG2.height))
        rectG3.lineWidth = 20
        rectG3.fillColor = white
        rectG3.strokeColor = lightBlue
        rectG3.lineCap = .square
        rectG3.lineJoin = .miter
        
        let rectG4 = Rectangle(frame: Rect(rectG3.frame.max.x,rectG3.frame.origin.y,  50, rectG3.height))
        rectG4.lineWidth = 20
        rectG4.fillColor = black
        rectG4.strokeColor = lightBlue
        rectG4.lineCap = .square
        rectG4.lineJoin = .miter
        
        let rectH1 = Rectangle(frame: Rect(rectG1.frame.origin.x,rectG1.frame.max.y,  rectG1.width, rectG1.width))
        rectH1.lineWidth = 20
        rectH1.fillColor = medBlue
        rectH1.strokeColor = lightBlue
        rectH1.lineCap = .square
        rectH1.lineJoin = .miter
        
        let rectH2 = Rectangle(frame: Rect(rectG1.frame.max.x,rectG1.frame.max.y, rectG2.width, rectH1.height))
        rectH2.lineWidth = 20
        rectH2.fillColor = navy
        rectH2.strokeColor = lightBlue
        rectH2.lineCap = .square
        rectH2.lineJoin = .miter
        
        let rectH3 = Rectangle(frame: Rect(rectH2.frame.max.x,rectH2.frame.origin.y,  rectG3.width, rectH2.height))
        rectH3.lineWidth = 20
        rectH3.fillColor = black
        rectH3.strokeColor = lightBlue
        rectH3.lineCap = .square
        rectH3.lineJoin = .miter
        
        let rectH4 = Rectangle(frame: Rect(rectH3.frame.max.x,rectH3.frame.origin.y,  50, rectH3.height))
        rectH4.lineWidth = 20
        rectH4.fillColor = orange
        rectH4.strokeColor = lightBlue
        rectH4.lineCap = .square
        rectH4.lineJoin = .miter
        
        let rectI1 = Rectangle(frame: Rect(rectH1.frame.origin.x,rectH1.frame.max.y,  rectH1.width+rectH2.width, rectH1.width))
        rectI1.lineWidth = 20
        rectI1.fillColor = medBlue
        rectI1.strokeColor = lightBlue
        rectI1.lineCap = .square
        rectI1.lineJoin = .miter
        
        let rectI2 = Rectangle(frame: Rect(rectI1.frame.max.x,rectI1.frame.origin.y,  rectH3.width, rectI1.height))
        rectI2.lineWidth = 20
        rectI2.fillColor = medBlue
        rectI2.strokeColor = lightBlue
        rectI2.lineCap = .square
        rectI2.lineJoin = .miter
        
        let rectI3 = Rectangle(frame: Rect(rectI2.frame.max.x,rectI2.frame.origin.y,  rectH3.width, rectI2.height))
        rectI3.lineWidth = 20
        rectI3.fillColor = lightGray
        rectI3.strokeColor = lightBlue
        rectI3.lineCap = .square
        rectI3.lineJoin = .miter
        
        let rectJ1 = Rectangle(frame: Rect(rectI1.frame.origin.x,rectI2.frame.max.y,  canvas.width+20, 500))//To fill the rest of the screen, only really visible in longer iPhones
        rectJ1.lineWidth = 20
        rectJ1.fillColor = sand
        rectJ1.strokeColor = lightBlue
        rectJ1.lineCap = .square
        rectJ1.lineJoin = .miter
        
        let triA1 = Triangle([Point(rectA1.frame.max.x,rectA1.frame.max.y),Point(rectA1.frame.max.x,rectA1.frame.max.y-50), Point(rectA1.frame.max.x-50,rectA1.frame.max.y)])
        triA1.lineWidth = 20
        triA1.fillColor = black
        triA1.strokeColor = lightBlue
        triA1.lineCap = .square
        triA1.lineJoin = .miter
        
        let triA2 = Triangle([Point(canvas.width,-20),Point(canvas.width, 50), Point(canvas.width-75, -20)])
        triA2.lineWidth = 20
        triA2.fillColor = sand
        triA2.strokeColor = lightBlue
        triA2.lineCap = .square
        triA2.lineJoin = .miter
        
        let triG1 = Triangle([Point(rectG3.frame.max.x, rectG3.frame.origin.y),Point(rectG4.frame.origin.x, rectG4.frame.origin.y+55),Point(rectG3.frame.max.x-55, rectG3.frame.origin.y)])
        triG1.lineWidth = 20
        triG1.fillColor = black
        triG1.strokeColor = lightBlue
        triG1.lineCap = .square
        triG1.lineJoin = .miter
        
        let triG2 = Triangle([Point(canvas.width+20, rectG4.frame.origin.y-10),Point(rectG4.frame.origin.x+4, rectG4.frame.origin.y+51),Point(canvas.width+20, rectG4.frame.max.y-30)])
        triG2.lineWidth = 20
        triG2.fillColor = orange
        triG2.strokeColor = lightBlue
        triG2.lineCap = .square
        triG2.lineJoin = .miter
        
        let triI1 = Triangle([Point(rectI1.frame.origin.x, rectI1.frame.max.y),Point(rectH1.frame.max.x,rectH1.frame.max.y+20),Point(rectI1.frame.origin.x+200, rectI1.frame.max.y)])
        triI1.lineWidth = 20
        triI1.fillColor = black
        triI1.strokeColor = lightBlue
        triI1.lineCap = .square
        triI1.lineJoin = .miter
        
        
        let polyA = Polygon([Point(rectA1.frame.max.x,rectA1.frame.max.y-50), Point(200,-10), Point(rectD2.frame.max.x,rectD2.frame.origin.y)])
        polyA.lineWidth = 20
        polyA.strokeColor = lightBlue
        polyA.lineCap = .square
        polyA.lineJoin = .miter
        
        let polyB = Polygon([Point(canvas.width,-20), Point(canvas.width, rectE3.frame.max.y), Point(canvas.width+20, rectE3.frame.max.y+20)])
        polyB.lineWidth = 20
        polyB.strokeColor = lightBlue
        polyB.lineCap = .square
        polyB.lineJoin = .miter
        
        let polyC = Polygon([Point(rectA3.frame.origin.x,rectA3.frame.origin.y), Point(rectA3.frame.origin.x,rectA3.frame.max.y-10), Point(canvas.width,rectC2.frame.origin.y)])
        polyC.lineWidth = 30
        polyC.strokeColor = navy
        polyC.lineCap = .square
        polyC.lineJoin = .miter
        
        let polyD = Polygon([Point(rectD2.frame.origin.x+10,rectD2.frame.max.y-10),Point(rectD2.frame.origin.x+10,rectD2.frame.origin.y+10),Point(rectD2.frame.origin.x+16,rectD2.frame.origin.y+10),Point(rectD2.frame.origin.x+80,rectD2.frame.max.y-10)])
        polyD.lineWidth = 0
        polyD.fillColor = black
        
        let polyE = Polygon( [Point(rectE2.frame.origin.x+10,rectE2.frame.max.y-10), Point(rectE2.frame.origin.x+10,rectE2.frame.origin.y+10), Point(rectE2.frame.origin.x+99,rectE2.frame.origin.y+10), Point(rectE2.frame.origin.x+158,rectE2.frame.max.y-10)])
        polyE.lineWidth = 0
        polyE.fillColor = white
        
        let polyF = Polygon([Point(rectI1.frame.origin.x, rectI1.frame.max.y), Point(rectH1.frame.max.x,rectH1.frame.max.y+20), Point(rectI1.frame.origin.x+600, rectI1.frame.max.y+300)])
        polyF.lineWidth = 30
        polyF.strokeColor = navy
        polyF.lineCap = .square
        polyF.lineJoin = .miter
        
        let lineA = Line(begin: Point(180,rectC2.frame.origin.y-5), end: Point(rectA3.frame.origin.x-5,rectA3.frame.max.y-20))
        lineA.lineWidth = 20
        lineA.strokeColor = lightBlue
        lineA.lineCap = .square
        lineA.lineJoin = .miter
        
        let lineB = Line((Point(triG1.points[2].x,triG1.points[2].y-3), Point(rectD2.frame.origin.x+25,rectD2.frame.origin.y+5)))
        lineB.lineWidth = 20
        lineB.strokeColor = lightBlue
        lineB.lineCap = .square
        lineB.lineJoin = .miter
        
        func lineB_pointSlope_x(y:Double)->Double
        {
            let slope = (lineB.endPoints.0.y-lineB.endPoints.1.y)/(lineB.endPoints.0.x-lineB.endPoints.1.x)
            //            print(slope)
            return ((y-lineB.endPoints.0.y)/slope + lineB.endPoints.0.x)
        }
        
        //adjust poly D & E
        polyD.points[2].x = lineB.endPoints.1.x
        polyD.points[3].x = lineB_pointSlope_x(y: rectD2.frame.max.y-20)
        
        polyE.points[2].x = lineB_pointSlope_x(y: rectE2.frame.origin.y)
        polyE.points[3].x = lineB_pointSlope_x(y: rectE2.frame.max.y-20)
        
        let anim_bottomright = ViewAnimation(duration:0.5){
            //squares rotate clockwise
            var temp = rectH3.frame
            rectH3.frame = rectH4.frame
            print(rectH3.frame)
            print(rectH4.frame)
            rectH4.frame = rectI3.frame
            rectI3.frame = rectI2.frame
            rectI2.frame = temp
        }
        
        rectH3.addTapGestureRecognizer{ (locations, center, state) in
            print("H3 Tapped!!")
            anim_bottomright.animate()
            
        }
        rectH4.addTapGestureRecognizer{ (locations, center, state) in
            print("H4 Tapped!!")
            anim_bottomright.animate()
            
        }
        rectI2.addTapGestureRecognizer{ (locations, center, state) in
            print("I2 Tapped!!")
            anim_bottomright.animate()
            
        }
        rectI3.addTapGestureRecognizer{ (locations, center, state) in
            print("I3 Tapped!!")
            anim_bottomright.animate()
            
        }
        
        polyC.addPanGestureRecognizer{ locations, center, translation, velocity, state in
            print("PolyC pan!!")
            polyC.points[1] = center
            if (state == .ended) {
                polyC.points[1] = Point(rectA3.frame.origin.x,rectA3.frame.max.y-10)//original point 1
            }
        }
        
        lineB.addPanGestureRecognizer{ locations, center, translation, velocity, state in
            print("lineB pan!!")
            lineB.endPoints.1.x = max(center.x,rectD2.frame.origin.x)//line cannot be dragged to the left past D2
            
            //x coordinates are adjusted so that the color follows the line
            polyD.points[2].x = lineB.endPoints.1.x
            polyD.points[3].x = lineB_pointSlope_x(y: rectD2.frame.max.y-20)
            
            polyE.points[2].x = lineB_pointSlope_x(y: rectE2.frame.origin.y)
            polyE.points[3].x = lineB_pointSlope_x(y: rectE2.frame.max.y-20)
        }
        
      
        
        canvas.add(rectA1)
        canvas.add(rectA2)
        canvas.add(rectA3)
        canvas.add(rectB1)
        canvas.add(rectB2)
        canvas.add(rectB3)
        canvas.add(rectC1)
        canvas.add(rectC2)
        canvas.add(rectD1)
        canvas.add(rectD2)
        canvas.add(rectD3)
        canvas.add(rectE1)
        canvas.add(rectE2)
        canvas.add(rectE3)
        canvas.add(rectF1)
        canvas.add(rectF2)
        canvas.add(rectF3)
        canvas.add(rectF4)
        canvas.add(rectG1)
        canvas.add(rectG2)
        canvas.add(rectG3)
        canvas.add(rectG4)
        canvas.add(rectH1)
        canvas.add(rectH2)
   

        canvas.add(rectI1)
        
        canvas.add(rectJ1)
        
        canvas.add(triA1)
        canvas.add(triA2)
        canvas.add(triG1)
        canvas.add(triG2)
        canvas.add(triI1)
        
        canvas.add(lineA)
        canvas.add(lineB)
        
        canvas.add(polyA)
        canvas.add(polyB)
       
        canvas.add(polyD)
        canvas.add(polyE)
        canvas.add(polyF)
        //reordered so that shapes respond as expected
        canvas.add(rectH3)
        canvas.add(rectH4)
        canvas.add(rectI2)
        canvas.add(rectI3)

        canvas.add(lineB)
         canvas.add(polyC)
    }
    
    
}
