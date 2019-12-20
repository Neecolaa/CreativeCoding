/*
 Assignment: Face-Off
 Student: Nicole Dubin
 Pasadena City College, Fall 2019
 Prof. Masood Kamandy
 Project Description: What once was scaredy dog is now scaredy cat. Responds to sound inputs with mouth opening, eyes widening/jiggling, and ears going up.
 Last Modified: October 6, 2019
 */
//  WorkSpace.swift
//
//  Face-Off Template for iPhone or iPad
//  Creative Coding for Mobile Devices
//
//     /^\˛˛˛˛˛˛˛/^\
//     /« ´ˆˆˆˆˆ` »\
//     |«´¸     ¸`»|
//     {  e     e  }
//     \    (∞)    /
//      |\ `-^-´ /|
//      |  ¨¨¨¨¨  |
//      |         |
//     /    ≈≈≈    \
//     /   ≈≈≈≈≈   \
//    /   ≈≈≈≈≈≈≈   \
//    |  ≈≈≈≈≈≈≈≈≈  |
//
//
//  by Masood Kamandy
//  © 2018 All Rights Reserved
//
//  Last updated 03/28/2018
//
//  More information at mkamandy@pasadena.edu

import UIKit
import AVFoundation
import C4

class WorkSpace: CanvasController {
    
    // MARK: INSTANCE VARIABLES
    // These variables are availabe throughout WorkSpace
    
    // Variables related to the microphone.
    
    var recorder: AVAudioRecorder!
    var timer: UIKit.Timer!
    var updated: ((Float) -> Void)?
    let minDecibels: Float = -80
    
    let settings: [String:Any] = [
        AVFormatIDKey: kAudioFormatLinearPCM,
        AVSampleRateKey: 44100,
        AVNumberOfChannelsKey: 1,
        AVLinearPCMBitDepthKey: 16,
        AVLinearPCMIsBigEndianKey: false,
        AVLinearPCMIsFloatKey: false
    ]
    
    // Change the multiplier to amplify the effect of sound on your shapes.
    // You can, optionally, create more than one multiplier.
    
    let multiplier = 1.0 // Larger = bigger
    var animationDuration = 0.05 // Larger = smoother
    var myVolume: Double! // Use this variable to control the size or position of your shapes.
    
    // MARK: SHAPE INSTANCE VARIABLES (DECLARE YOUR SHAPES HERE)
    
    var head: RegularPolygon!
    var muzzle: RegularPolygon!
    var nose: Triangle!
    var lines: Polygon!
    var mouth: Polygon!
    var left: Polygon!
    var right: Polygon!
    
    var leftEar: Polygon!
    var leftMid: Point!
    var rightEar: Polygon!
    var rightMid: Point!
    
    var rightEye: Ellipse!
    var rightIris: Ellipse!
    var rightPupil: Ellipse!
    
    var leftEye: Ellipse!
    var leftIris: Ellipse!
    var leftPupil: Ellipse!
    

    // MARK: CHANGE SHAPES FUNCTION (WORK HERE)
    // You can change the values of your shapes in here and it will correspond to your
    // mic input.
    
    func changeShapes() {
        
        //I don't have a great grasp on how rotation affects the ellipse frame, but WOW IT'S FINICKY!!
        //You would think that making two eyes that look the same would be easy, but it wasn't. Tried my best to work it in! It's a feature!!
        
        //Clears translation
        rightEye.transform.translation = Vector()
        rightIris.transform.translation = Vector()
        rightPupil.transform.translation = Vector()
        
        //moves eye to correct place on face
        rightEye.transform.translate(Vector(x: -45, y: -55))
        rightIris.transform.translate(Vector(x: -55, y: -55))
        rightPupil.transform.translate(Vector(x: -60, y: -55))
        
        //changes eye size to respond to volume
        rightEye.frame = Rect(0,0,myVolume,9*myVolume)
        rightIris.frame = Rect(0,0,myVolume,8*myVolume)
        rightPupil.frame = Rect(0,0,15,5*myVolume)
        
        //keeps eye on face rather than in the corner of the screen
        rightEye.center = head.center
        rightIris.center = head.center
        rightPupil.center = head.center
        
        //tries to compensate for eyes getting bigger by moving them (rotated) up, but really just makes them raised away from the muzzle. Good enough!
        rightEye.transform.translate(Vector(x: -myVolume*2, y: 0))
        rightIris.transform.translate(Vector(x: -myVolume*2, y: 0))
        rightPupil.transform.translate(Vector(x: -myVolume*2, y: 0))
        
        //mostly the same stuff for the left eye
        leftEye.transform.translation = Vector()
        leftIris.transform.translation = Vector()
        leftPupil.transform.translation = Vector()
        leftEye.transform.translate(Vector(x: -45, y: 55))
        leftIris.transform.translate(Vector(x: -55, y: 55))
        leftPupil.transform.translate(Vector(x: -60, y: 55))
        //This is where I don't get how rotation affects the frame. These numbers are so different!!
        leftEye.frame = Rect(0,0,8*myVolume, 4*myVolume)
        leftIris.frame = Rect(0,0,7*myVolume,3*myVolume)
        leftPupil.frame = Rect(0,0,4.4*myVolume,1.65*myVolume)
        leftEye.center = head.center
        leftIris.center = head.center
        leftPupil.center = head.center
        leftEye.transform.translate(Vector(x: -myVolume*2, y: 0))
        leftIris.transform.translate(Vector(x: -myVolume*2, y: 0))
        leftPupil.transform.translate(Vector(x: -myVolume*2, y: 0))
        
        
        //mouth gets bigger in relation to the volume
        //myVolume/75 because the volume's max seems to be 75
        mouth.points[1] = lerp(lines.points[1], lines.points[0], at: myVolume/75)
        mouth.points[2] = Point(mouth.points[0].x,mouth.points[1].y+40)
        mouth.points[3] = lerp(lines.points[1], lines.points[2], at: myVolume/75)
        
        
        //ears get taller in relation to volume
        rightMid = lerp(rightEar.points[0], rightEar.points[1], at: 0.25 + myVolume/75)
        rightEar.points[2].y = rightMid.y-(500*myVolume/50)
        
        leftMid = lerp(leftEar.points[0], leftEar.points[1], at: 0.25 + myVolume/75)
        leftEar.points[2].y = leftMid.y-(500*myVolume/50)
        
        print(myVolume)
    }

    
    // MARK: SETUP
    
    override func setup() {
        // Set up the microphone to start listening.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print(error.description)
        }
        
        do {
            let url = URL(string: NSTemporaryDirectory().appending("tmp.caf"))!
            print("recording to")
            print(url)
            try recorder = AVAudioRecorder(url: url, settings: settings)
        } catch {
            print("error!")
        }
        
        // Work your magic here. All shape and attribute variables have to be assigned an initial value.
        canvas.backgroundColor = Color(0x5A7684)
        
        head = RegularPolygon(center: canvas.center, radius: 250.0, sides: 6, phase: 0.0)
        head.fillColor = Color(0xFDF0DF)
        head.strokeColor = Color(0xDDBB9A)
        head.lineWidth = 7.0
        
        canvas.add(head)
        
        muzzle = RegularPolygon(center: Point(canvas.center.x, canvas.center.y+120), radius: 120.0, sides: 5, phase: .pi/2 + .pi)
        muzzle = RegularPolygon(center: Point(canvas.center.x, canvas.center.y+120), radius: 120.0, sides: 6, phase: 0)
        muzzle.fillColor = Color(0x3A1609)
        muzzle.strokeColor = Color(0x1D0B05)
        muzzle.lineWidth = 14.0
        canvas.add(muzzle)
        
        nose = Triangle([Point(),Point(),Point(),Point()])
        nose.points[0] = nose.convert(muzzle.points[4], from:muzzle)
        nose.points[1] = nose.convert(muzzle.points[5], from:muzzle)
        nose.points[2] = lerp(nose.points[0],nose.points[1], at: 0.5)
        nose.points[2].y += 75
        nose.points[3] = nose.points[0]
        nose.fillColor = Color(0x191717)
        nose.strokeColor = black
        nose.lineWidth = 10.0
        
        lines = Polygon([Point(),Point(),Point()])
        lines.points[0] = lines.convert(muzzle.points[1],from:muzzle)//right side
        lines.points[1] = lines.convert(nose.points[2],from:nose)//middle/nose
        lines.points[2] = lines.convert(muzzle.points[2],from:muzzle)//left side
        lines.strokeColor = Color(0x1D0B05)
        lines.lineWidth = 10.0
        
        
        mouth = Polygon([Point(),Point(),Point(),Point(),Point()])
        mouth.points[0] = nose.points[2]
        mouth.points[1] = lerp(lines.points[1], lines.points[0], at: 0.25)
        mouth.points[2] = Point(mouth.points[0].x,mouth.points[1].y+30)
        mouth.points[3] = lerp(lines.points[1], lines.points[2], at: 0.25)
        mouth.points[4] = mouth.points[0]
        mouth.fillColor = Color(0x590606)
        mouth.strokeColor = lines.strokeColor
        mouth.lineWidth = 5.0
        
        canvas.add(mouth)
        canvas.add(lines)
        canvas.add(nose)
        
        left = Polygon([Point(),Point()])
        left.points[0] = left.convert(head.points[4], from: head)
        left.points[1] = left.convert(head.points[3], from: head)
        left.lineWidth = 10
        left.strokeColor = C4Blue
        
        canvas.add(left)
        
        right = Polygon([Point(),Point()])
        right.points[0] = right.convert(head.points[5], from: head)
        right.points[1] = right.convert(head.points[0], from: head)
        right.lineWidth = 10
        right.strokeColor = C4Pink
        right.anchorPoint = right.points[0]
        
        canvas.add(right)
        
        leftEar = Polygon([Point(),Point(),Point(),Point()])
        leftEar.points[0] = leftEar.convert(head.points[4], from: head)
        leftEar.points[1] = leftEar.convert(head.points[3], from: head)
        leftEar.points[2] = lerp(leftEar.points[0], leftEar.points[1], at: 0.5)
        leftEar.points[2].x -= 150
        leftEar.points[2].y -= 200
        leftEar.points[3] = leftEar.points[0]
        leftEar.fillColor = Color(0x3A1609)
        leftEar.strokeColor = Color(0x1D0B05)
        leftEar.lineWidth = 10.0
        
        canvas.add(leftEar)
        
        rightEar = Polygon([Point(),Point(),Point(),Point()])
        rightEar.points[0] = rightEar.convert(head.points[5], from: head)
        rightEar.points[1] = rightEar.convert(head.points[0], from: head)
        rightEar.points[2] = lerp(rightEar.points[0], rightEar.points[1], at: 0.5)
        rightEar.points[2].x += 150
        rightEar.points[2].y -= 200
        rightEar.points[3] = rightEar.points[0]
        rightEar.fillColor = Color(0x3A1609)
        rightEar.strokeColor = Color(0x1D0B05)
        rightEar.lineWidth = 10.0
        
        canvas.add(rightEar)
        
        rightEye = Ellipse(frame: Rect(0,0, 75, 75))
        rightEye.center = head.center
        rightEye.rotation = 2 * .pi/3.0
        rightEye.fillColor = Color(0xF9F9F9)
        rightEye.strokeColor = Color(0xDDBB9A)
        rightEye.lineWidth = 3.0
        canvas.add(rightEye)
        
        rightIris = Ellipse(frame: Rect(0,0, 75, 75))
        rightIris.center = rightEye.center
        rightIris.rotation = 2 * .pi/3.0
        rightIris.fillColor = Color(0x873E08)
        rightIris.strokeColor = Color(0x44362D)
        canvas.add(rightIris)
        
        rightPupil = Ellipse(frame: Rect(0,0, 75, 75))
        rightPupil.center = rightEye.center
        rightPupil.rotation = 2 * .pi/3.0
        rightPupil.fillColor = black
        rightPupil.strokeColor = black
        canvas.add(rightPupil)
        
        
        leftEye = Ellipse(frame: Rect(0,0, 75, 75))
        leftEye.center = head.center
        leftEye.rotation =  .pi - (2 * .pi/3.0)
        leftEye.fillColor = Color(0xF9F9F9)
        leftEye.strokeColor = Color(0xDDBB9A)
        leftEye.lineWidth = 3.0
        canvas.add(leftEye)
        
        leftIris = Ellipse(frame: Rect(0,0, 75, 75))
        leftIris.center = leftEye.center
        leftIris.rotation = .pi - (2 * .pi/3.0)
        leftIris.fillColor = Color(0x873E08)
        leftIris.strokeColor = Color(0x44362D)
        canvas.add(leftIris)
        
        leftPupil = Ellipse(frame: Rect(0,0, 75, 75))
        leftPupil.center = leftEye.center
        leftPupil.rotation = .pi - (2 * .pi/3.0)
        leftPupil.fillColor = black
        leftPupil.strokeColor = black
        canvas.add(leftPupil)
        
        // Start the microphone.
        
        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        recorder.record()
        
        // Ask the computer to continously check the microphone level at an interval.
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateMeter), userInfo: nil, repeats: true)
        
    }
    
    // MARK: MIC SIGNAL CONVERSION
    // Converting input from microphone to useful, human-readable numbers.
    
    var level: Float {
        
        let decibels = recorder.averagePower(forChannel: 0)
        
        if decibels < minDecibels {
            return 0
        } else if decibels >= 0 {
            return 1
        }
        
        let minAmp = powf(10, 0.05 * minDecibels)
        let inverseAmpRange = 1 / (1 - minAmp)
        let amp = powf(10, 0.05 * decibels)
        let adjAmp = (amp - minAmp) * inverseAmpRange
        
        return sqrtf(adjAmp)
        
    }
    
    var pos: Float {
        // linear level * by max + min scale (20 - 130db)
        return level * 130 + 20
    }
    
    // MARK: SAMPLE THE MICROPHONE AND CALL THE CHANGE SHAPE FUNCTION
    // Sample the microphone.
    
    @objc func updateMeter() {
        recorder.updateMeters()
        updated?(pos)
        myVolume = Double(self.pos)/2.0*self.multiplier
        //label.text = "\(Int(pos))dB"
        ViewAnimation(duration: animationDuration) {
            self.changeShapes()
            }.animate()
    }
    
    // MARK: MAP FUNCTION
    
    // This is a mapping function that remaps a number from one range to another.
    // Based on Processing's map() function translated into Swift.
    // More info available here: https://processing.org/reference/map_.html'
    
    // Use this if you need to modify the behavior of the sound variable
    // proportionally in different areas.
    
    func map(valueToModify: Double, low1: Double, high1: Double, low2: Double, high2: Double) -> Double {
        let result = (low2 + (valueToModify - low1)) * (high2 - low2) / (high1 - low1)
        return result
    }
    
}

