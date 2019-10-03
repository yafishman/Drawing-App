//
//  CreateLine.swift
//  YakFishman-Lab3
//
//  Created by Yak Fishman on 9/27/18.
//  Copyright © 2018 Yak Fishman. All rights reserved.
//

import Foundation
import UIKit

class CreateLine : UIView {
    var lines: [Line] = []
    var currentLine : Line?
    
    override func draw(_ rect: CGRect) {
        var index = 0
        while(index < lines.count) {
            let lineDrawing = lines[index].path
            lines[index].color.setStroke()
            lineDrawing.lineWidth = lines[index].width
            lineDrawing.stroke()
            index += 1
        }
        guard let unwrappedLine = currentLine else {
            return
        }
        unwrappedLine.color.setStroke()
        unwrappedLine.path.lineWidth = unwrappedLine.width
        unwrappedLine.path.stroke()
    }
    
    func clear() {
        lines.removeAll()
    }
    
    func undo() {
        if(lines.count >= 1) {
            lines.removeLast()
        }
    }
}
