//
//  ViewController.swift
//  YakFishman-Lab3
//
//  Created by Yak Fishman on 9/25/18.
//  Copyright © 2018 Yak Fishman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var clearLabel: UIButton!
    @IBOutlet weak var undoLabel: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var colorStack: UIStackView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var tictactoeButton: UIButton!
    @IBOutlet weak var redDot: UILabel!
    @IBOutlet weak var orangeDot: UILabel!
    @IBOutlet weak var yellowDot: UILabel!
    @IBOutlet weak var greenDot: UILabel!
    @IBOutlet weak var blueDot: UILabel!
    @IBOutlet weak var purpleDot: UILabel!
    @IBOutlet weak var blackDot: UILabel!
    @IBOutlet weak var lineLabel: UIButton!

    //all for creative portion
    var mode = 0
    var wasThree = false
    let layer = CAShapeLayer()
    let tLeft = CAShapeLayer()
    let tRight = CAShapeLayer()
    let tTop = CAShapeLayer()
    let tBottom = CAShapeLayer()
    var straightLine = false
    
    @IBOutlet var newView: CreateLine!
    var color = UIColor.red
    var curLine: [CGPoint] = []
    var currentWidth = CGFloat (20)
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPt = (touches.first)!.location(in: view) as CGPoint
        curLine.append(touchPt)
        newView.setNeedsDisplay()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPt = (touches.first)!.location(in: view) as CGPoint
        curLine.append(touchPt)
        newView.currentLine = Line(color: color, width: currentWidth, path: createQuadPath(points: curLine))
        newView.setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newLine = Line(color: color,  width: currentWidth, path: createQuadPath(points: curLine))
        newView.lines.append(newLine)
        if (!straightLine){
            curLine = []
        }
        newView.currentLine = nil
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        currentWidth = CGFloat (sender.value)
    }
    
    @IBAction func clearButton(_ sender: Any) {
        if straightLine {
            curLine = []
        }
        newView.clear()
        newView.setNeedsDisplay()
    }
    
    @IBAction func undoButton(_ sender: Any) {
        if straightLine {
            curLine = []
        }
        newView.undo()
        newView.setNeedsDisplay()
        
    }
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        let newPt = CGPoint(x:(first.x+second.x)/2,y:(first.y+second.y)/2)
        return newPt
    }
    @IBAction func changeRed(_ sender: Any) {
        color = UIColor.red
        redDot.alpha = 1
        orangeDot.alpha = 0
        yellowDot.alpha = 0
        greenDot.alpha = 0
        blueDot.alpha = 0
        purpleDot.alpha = 0
        blackDot.alpha = 0
    }
    
    @IBAction func changeOrange(_ sender: Any) {
        color = UIColor.orange
        redDot.alpha = 0
        orangeDot.alpha = 1
        yellowDot.alpha = 0
        greenDot.alpha = 0
        blueDot.alpha = 0
        purpleDot.alpha = 0
        blackDot.alpha = 0
    }
    
    @IBAction func changeYellow(_ sender: Any) {
        color = UIColor.yellow
        redDot.alpha = 0
        orangeDot.alpha = 0
        yellowDot.alpha = 1
        greenDot.alpha = 0
        blueDot.alpha = 0
        purpleDot.alpha = 0
        blackDot.alpha = 0
    }
    
    @IBAction func changeGreen(_ sender: Any) {
        color = UIColor.green
        redDot.alpha = 0
        orangeDot.alpha = 0
        yellowDot.alpha = 0
        greenDot.alpha = 1
        blueDot.alpha = 0
        purpleDot.alpha = 0
        blackDot.alpha = 0
    }
    
    @IBAction func changeBlue(_ sender: Any) {
        color = UIColor.blue
        redDot.alpha = 0
        orangeDot.alpha = 0
        yellowDot.alpha = 0
        greenDot.alpha = 0
        blueDot.alpha = 1
        purpleDot.alpha = 0
        blackDot.alpha = 0
    }
    @IBAction func changePurple(_ sender: Any) {
        color = UIColor.purple
        redDot.alpha = 0
        orangeDot.alpha = 0
        yellowDot.alpha = 0
        greenDot.alpha = 0
        blueDot.alpha = 0
        purpleDot.alpha = 1
        blackDot.alpha = 0
    }
    
    @IBAction func changeBlack(_ sender: Any) {
        color = UIColor.black
        redDot.alpha = 0
        orangeDot.alpha = 0
        yellowDot.alpha = 0
        greenDot.alpha = 0
        blueDot.alpha = 0
        purpleDot.alpha = 0
        blackDot.alpha = 1
    }
    @IBAction func circleAction(_ sender: Any) {
        tictactoeButton.alpha=1
        tLeft.removeFromSuperlayer()
        tRight.removeFromSuperlayer()
        tTop.removeFromSuperlayer()
        tBottom.removeFromSuperlayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 10, y: 150, width: 350, height: 350), cornerRadius: 350).cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor=UIColor.black.cgColor
        newView.layer.addSublayer(layer)
        if(mode == 1) {
            layer.removeFromSuperlayer()
            mode = 0
            circleButton.alpha=1
        } else {
            mode = 1
            circleButton.alpha=0.35
        }
    }
    
    @IBAction func lineAction(_ sender: Any) {
        if straightLine {
            straightLine=false
            curLine = []
            lineLabel.alpha=1
        } else {
            straightLine=true
            lineLabel.alpha=0.35
        }
    }
    
    @IBAction func tictactoeAction(_ sender: Any) {
        circleButton.alpha=1
        layer.removeFromSuperlayer()
        tLeft.path = UIBezierPath(roundedRect: CGRect(x: 115, y: 70, width: 1, height: 500), cornerRadius: 0).cgPath
        tLeft.strokeColor = UIColor.black.cgColor
        newView.layer.addSublayer(tLeft)
        tRight.path = UIBezierPath(roundedRect: CGRect(x: 250, y: 70, width: 1, height: 500), cornerRadius: 0).cgPath
        tRight.strokeColor = UIColor.black.cgColor
        newView.layer.addSublayer(tRight)
        tTop.path = UIBezierPath(roundedRect: CGRect(x: 10, y: 225, width: 350, height: 1), cornerRadius: 0).cgPath
        tTop.strokeColor = UIColor.black.cgColor
        newView.layer.addSublayer(tTop)
        tBottom.path = UIBezierPath(roundedRect: CGRect(x: 10, y: 400, width: 350, height: 1), cornerRadius: 0).cgPath
        tBottom.strokeColor = UIColor.black.cgColor
        newView.layer.addSublayer(tBottom)
        if(mode == 2) {
            tLeft.removeFromSuperlayer()
            tRight.removeFromSuperlayer()
            tTop.removeFromSuperlayer()
            tBottom.removeFromSuperlayer()
            mode = 0
            tictactoeButton.alpha=1
        } else {
            mode = 2
            tictactoeButton.alpha=0.35
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redDot.alpha = 1
        orangeDot.alpha = 0
        yellowDot.alpha = 0
        greenDot.alpha = 0
        blueDot.alpha = 0
        purpleDot.alpha = 0
        blackDot.alpha = 0
        color = UIColor.red
        mode = 0
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

