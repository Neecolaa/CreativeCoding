/*
 Assignment: Collage Engine II
 Student: Nicole Dubin
 Pasadena City College, Fall 2019
 Prof. Masood Kamandy
 Project Description: Generates collages of cats on boats faced with a really big fish. The fish darts around randomly within its "area" (top 1/3 of screen) while the boat and cat bob gently up and down.
 Last Modified: October 14, 2019
 */
//  Utilizes the CollageEngineTemplate
//  by Masood Kamandy
//  © 2018 All Rights Reserved
//
//  Last updated 04/30/2018
//
//  More information at mkamandy@pasadena.edu


import UIKit
import C4

class WorkSpace: CanvasController {
    
    override func setup() {
        let boats = [Image("boat2"),Image("boat3")]//these boats were most consistent with the cats "sitting" on them properly
        let cats = [Image("cat0"),Image("cat1"),Image("cat2"),Image("cat3"),Image("cat4"),Image("cat5"),Image("cat6"),Image("cat7")]
        let fishies = [Image("fish0"),Image("fish1"),Image("fish2"),Image("fish3"),Image("fish4"),Image("fish5"),Image("fish6")]
        
        var fish: Image?
        var cat: Image?
        var boat: Image?
        
        func createCollage(){
            let background = Image("waterbg")
            background?.constrainsProportions = true
            background?.height = canvas.height
            
            canvas.add(background)
            
            boat = boats[random(below: boats.count)]
            boat?.constrainsProportions = true
            boat?.width = canvas.width*(9/10)
            boat?.origin = Point(0,Int(canvas.height/2)+random(below: Int(canvas.height/4)))
            canvas.add(boat)
            
            cat = cats[random(below: cats.count)]
            cat?.constrainsProportions = true
            cat?.width = canvas.width/3
            cat?.center = boat!.center
            canvas.add(cat)
            
            fish = fishies[random(below: fishies.count)]
            fish?.constrainsProportions = true
            fish?.width = canvas.width
            fish?.origin = Point(random(below: Int(canvas.width/3)),random(below: Int(canvas.width/3)))
            canvas.add(fish)
        }
        
        createCollage()
        
        
        
        let boatAnimation = ViewAnimation(duration: 5.0) {
            boat?.origin.y -= 40
            cat?.center = boat!.center
        }
        
        boatAnimation.repeats = true
        boatAnimation.autoreverses = true
        boatAnimation.animate()

        let fishAnimation = ViewAnimation(duration: 1.5) {
            fish?.origin = Point(random(below: Int(self.canvas.width)),random(below: Int(self.canvas.width/3)))
        }
        
        let fishTimer = C4.Timer(interval: 1.5) {
            fishAnimation.animate()
        }
        
        fishTimer.start()
        fishTimer.fire()
        
        canvas.addTapGestureRecognizer{ (locations, center, state) in
            createCollage()
            boatAnimation.animate()
        }
    }
    
    
}


