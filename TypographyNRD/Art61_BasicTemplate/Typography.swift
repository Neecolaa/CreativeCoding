/*
 Assignment: Typography with Objects
 Student: Nicole Dubin
 Pasadena City College, Fall 2019
 Prof. Masood Kamandy
 Project Description: My initials (NRD) drawn using only overlapping, transulcent circles. Now with classes
 Last Modified: October 26, 2019
 */
//
//  Typography.swift
//  Art61_BasicTemplate
//
//  Created by Nicole Dubin on 10/25/19.
//

import Foundation
import C4

//Base class for all letters (since their inits would all be the same)
class Letter {
    var canvas: C4.View
    var origin:Point
    var rad:Double
    var color:Color
    var spread:Double
    var circles:Array<Circle>
    
    init(canvas:C4.View,origin:Point,rad:Double,color:Color,spread:Double) {
        self.canvas = canvas//where the letter will be drawn
        self.origin = origin//the center of the top leftmost circle
        self.rad = rad//the radius of each individual circle
        self.color = color//the color of the outline
        self.spread = spread//the rate of spread (distance) between circles
        
        self.circles = (0..<30).map {_ in Circle(center: origin, radius: rad)}//generates distinct Circle
        
        for circ in circles {
            circ.strokeColor = color
            circ.fillColor = circ.strokeColor?.colorWithAlpha(0.15)//circle is filled with translucent color of outline
        }
    }
    
    func create() {
        
    }
    
    func draw() {
        create()//does nothing in base, arranges letter in subclasses
        
        for circ in circles {
            self.canvas.add(circ)
        }
    }
}

class N:Letter {
    override func create() {
        //Left vertical line
        for i in 0..<10 {
            let circ = circles[i]
            circ.center.y += Double(rad*spread)*Double(i)
        }
        
        //Diagonal line in middle
        for i in 0..<10 {
            let circ = circles[10+i]//start from where we left off
            circ.center.y += Double(rad*spread)*Double(i)
            circ.center.x += Double(rad*spread)*Double(i)*0.75//scaling to make the size more similar to the other letters
        }
        
        //Right vertical line
        for i in 0..<10 {
            let circ = circles[20+i]
            circ.center.x = circles[19].center.x//using end of diagonal for x-coordinate
            circ.center.y += Double(rad*spread)*Double(i)
            
        }
        
    }
}

class R:Letter {
    override func create() {
        
        //Vertical stroke
        for i in 0..<10 {
            let circ = circles[i]
            circ.center.y += Double(rad*spread)*Double(i)
        }
        
        //Arc on top half using sine curve
        for i in 0..<10 {
            let circ = circles[10+i]
            circ.center.x += Double(rad*rad*spread*0.25)*sin((.pi/10.0)*Double(i))//0.25 scaling to make the arc more prominent, 10.0 so that the semicircle is completed
            circ.center.y += Double(rad*spread)*(Double(i)/2.0)//increases half as fast because there are twice as many circles in the same ammount of distance
        }
        
        //Diagonal on lower half
        for i in 0..<10 {
            let circ = circles[20+i]
            circ.center = circles[19].center
            circ.center.y += Double(rad*spread)*Double(i)/2.0
            circ.center.x += Double(rad*spread)*Double(i)/2.0
        }
    }
}

class D:Letter {
    override func create() {
        //Vertical line
        for i in 0..<10 {
            let circ = circles[i]
            circ.center.y += Double(rad*spread)*Double(i)
        }
        
        //Semicircle using sine curve
        for i in 0..<20 {
            let circ = circles[10+i]
            circ.center.x += Double(rad*spread*rad*0.25)*sin((.pi/20.0)*Double(i))//0.25 scaling to make the arc more prominent without too much spreading, 20.0 so that the semicircle is completed
            circ.center.y += Double(rad*spread)*(Double(i)/2.0)
        }
    }
}

class NRD {
    var canvas: C4.View
    var rad:Double
    var color:Color
    var spread:Double
    
    var nOrigin:Point
    var rOrigin:Point
    var dOrigin:Point
    
    init(canvas:C4.View,rad:Double,color:Color,spread:Double) {
        //allows for choosing the radius, color, & spread. letter origins still random
        self.canvas = canvas//where the letter will be drawn
        self.rad = rad//the radius of each individual circle
        self.color = color//the color of the outline
        self.spread = spread//the rate of spread (distance) between circles
        
        self.nOrigin = Point(random(in: 20.0..<canvas.width-20.0),random(in: 20.0..<canvas.height-50.0))
        self.rOrigin = Point(random(in: 20.0..<canvas.width-20.0),random(in: 20.0..<canvas.height-50.0))
        self.dOrigin = Point(random(in: 20.0..<canvas.width-20.0),random(in: 20.0..<canvas.height-50.0))
    }
    
    init(canvas:C4.View) {
        //randomly assignes radius, color, spread, and origins
        self.canvas = canvas//where the letter will be drawn
        self.rad = random(in: 10.0..<35.0)
        self.color = Color(
            red: random(below: 256),
            green: random(below: 256),
            blue: random(below: 256),
            alpha: 1.0)
        self.spread = random(in: 0.25..<2.0)
        
        self.nOrigin = Point(random(in: 20.0..<canvas.width-20.0),random(in: 20.0..<canvas.height-50.0))
        self.rOrigin = Point(random(in: 20.0..<canvas.width-20.0),random(in: 20.0..<canvas.height-50.0))
        self.dOrigin = Point(random(in: 20.0..<canvas.width-20.0),random(in: 20.0..<canvas.height-50.0))

    }
    
    func randomize() {
        //generates new values for all properties except canvas
        self.rad = random(in: 10.0..<35.0)
        self.color = Color(
            red: random(below: 256),
            green: random(below: 256),
            blue: random(below: 256),
            alpha: 1.0)
        self.spread = random(in: 0.25..<2.0)
        
        self.nOrigin = Point(random(in: 20.0..<canvas.width-20.0),random(in: 20.0..<canvas.height-50.0))
        self.rOrigin = Point(random(in: 20.0..<canvas.width-20.0),random(in: 20.0..<canvas.height-50.0))
        self.dOrigin = Point(random(in: 20.0..<canvas.width-20.0),random(in: 20.0..<canvas.height-50.0))

    }
    
    func draw() {
        ShapeLayer.disableActions = true
        let n = N(canvas: self.canvas, origin: self.nOrigin, rad: self.rad, color: self.color, spread: self.spread)
        let r = R(canvas: self.canvas, origin: self.rOrigin, rad: self.rad, color: self.color, spread: self.spread)
        let d = D(canvas: self.canvas, origin: self.dOrigin, rad: self.rad, color: self.color, spread: self.spread)
        
        n.draw();
        r.draw();
        d.draw();
    }
}
