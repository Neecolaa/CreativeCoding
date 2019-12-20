  /*
   Assignment: Final Project
   Student: Nicole Dubin
   Pasadena City College, Fall 2019
   Prof. Masood Kamandy
   Project Description: A simulation of animal hoarding. Tap on the cats to take care of them. Cats that overlap can be moved out of the way by panning with them. New cats will be added at regular intervals. Cats will transition from "happy" to "sad" if they aren't tapped often enough.
   Last Modified: December 7th, 2019
   */
  //  Utilizes the Art61_BasicTemplate
  //  Created by MASOOD KAMANDY on 4/30/18.
  //  Copyright © 2018 Masood Kamandy. All rights reserved.

import UIKit
import C4

class WorkSpace: CanvasController {
    
    var nextPage: TextShape!
    var prevPage: TextShape!
    
    override func setup() {

        var kitties = (0..<40).map {_ in Kitty(canvas: canvas, size: random(in: canvas.width/4.0 ..< canvas.width/2.0), center: Point(random(in: 0.0 ..< canvas.width),random(in: 0.0 ..< canvas.height)))} //kitty machine!
        //40 animals is the average ammount in hoarding situations
        
        
        canvas.on(event: NSNotification.Name("Dead")) {
            //background darkens
            var newColor = self.canvas.backgroundColor
            newColor?.red -= 1.0/Double(kitties.count)
            newColor?.blue -= 1.0/Double(kitties.count)
            newColor?.green -= 1.0/Double(kitties.count)
            
            self.canvas.backgroundColor = newColor
        }
        
        var quant = 0; //how many cats are visible
        var addCat = C4.Timer(interval: 5.0, count: kitties.count) {
            //add another cat to the hoard
            kitties[quant].draw()
            quant += 1;
            self.canvas.post(NSNotification.Name("added"))
        }
        
        addCat.start()
        addCat.fire()
    }
    
    
    
}



class Kitty {
    var canvas: C4.View
    var hap = Image("hapkitty")
    var sad = Image("sadkitty")
    var hitbox: Ellipse
    var transition: ViewAnimation!
    var kitdrag: UIPanGestureRecognizer!
    var healthTimer: C4.Timer!
    var conditionFactor = 1.0
    
    init(canvas: C4.View, size: Double, center: Point) {
        self.canvas = canvas
        
        hap?.constrainsProportions = true
        hap?.width = size
        hap?.opacity = 1.0
        hap?.center = center
        
        hap!.frame.origin.x = clamp(hap!.frame.origin.x, min: 0 , max: self.canvas.width-hap!.width)
        hap!.frame.origin.y = clamp(hap!.frame.origin.y, min: 0 , max: self.canvas.height-hap!.height)
        
        
        sad?.opacity = 0.0
        sad?.constrainsProportions = true
        sad?.width = hap!.width
        sad?.center = hap!.center
        sad?.frame.origin = hap!.frame.origin
        
        hitbox = Ellipse(frame: Rect(hap!.origin.x, hap!.origin.y, hap!.width, hap!.height))//closest to the shape of the cat with minimum overlap
        hitbox.opacity = 0.0
        hitbox.center = hap!.center
        
//        transition = ViewAnimation(duration: 15.0)
//        {
//            self.hap?.opacity = 0.0
//            self.sad?.opacity = 1.0
//        }
        
        healthTimer = C4.Timer(interval: 0.025) {
            //kitties have worsening health if you don't take care of them (clicking)
            if(self.sad!.opacity < 1.0)//still alive
            {
                self.hap?.opacity -= 0.001 * self.conditionFactor
                self.sad?.opacity += 0.001 * self.conditionFactor
            }
            else //kitty died
            {
                var ded = Image("dedkitty")
                self.sad?.contents = ded!.contents
                self.hap!.removeFromSuperview() //invisible anyways
                self.sad?.post(NSNotification.Name("Dead")) //for background change
                self.conditionFactor += 3.0 //dead bodies are generally hazardous to health
                self.healthTimer.stop() //no longer gets health updates
            }
        }
        
        hitbox.addTapGestureRecognizer { center, location, state in
            if(self.sad!.opacity < 1.0)
            {
                //improves health of kitty
                self.hap?.opacity += 0.1
                self.sad?.opacity -= 0.1
            }
            //doesn't work on dead kitties :<
            
        }
        
        kitdrag = hitbox.addPanGestureRecognizer { locations, center, translation,
            velocity, state in
            //move cat?
            //adapted from lerp video lecture
            self.hitbox.center += translation
            self.hap?.frame.origin = self.hitbox.origin
            self.sad?.frame.origin = self.hitbox.origin
            
            self.kitdrag.setTranslation(CGPoint(), in: self.canvas.view)
            
        }
        hitbox.on(event: NSNotification.Name("Added")) {
            self.conditionFactor += 1.0 //crowding leads to poorer conditions
        }
        
    }
    
    func draw(startSad: Bool = false) {
        canvas.add(hap)
        canvas.add(sad)
        canvas.add(hitbox)
        self.healthTimer.start()
    }
}
