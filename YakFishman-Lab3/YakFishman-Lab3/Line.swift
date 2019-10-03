//
//  Line.swift
//  YakFishman-Lab3
//
//  Created by Yak Fishman on 10/1/18.
//  Copyright © 2018 Yak Fishman. All rights reserved.
//

import Foundation
import UIKit

class Line {
    var color = UIColor.red
    var path:UIBezierPath
    var width:CGFloat
    
    init(color: UIColor, width: CGFloat, path:UIBezierPath) {
        self.color = color
        self.path = path
        self.width = width
        path.lineCapStyle = CGLineCap.round
        path.lineJoinStyle = .round
    }
}
