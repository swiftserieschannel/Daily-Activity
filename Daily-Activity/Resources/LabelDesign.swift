//
//  LabelDesign.swift
//  Luxottica
//
//  Created by Mayank Bajpai on 15/11/18.
//  Copyright © 2018 Mayank Bajpai. All rights reserved.
//

import UIKit

class LabelDesign: UILabel {
    
    // 1-light
    // 2-bold
    // default-regular
    
    //MARK:- Life Cycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Adjusting UIFont type according to the Tag provided over UIStoryboard.
        
        
        let fontSize = self.font.pointSize
        let updateFont = Utile.getFontSizeAcordingToDevices(currentFontSize: fontSize)
        
        if self.tag == 1{
            self.font = UIFont(name: AppFont.light, size: updateFont)
        }
        else if self.tag == 2{
            self.font = UIFont(name: AppFont.bold, size: updateFont)
        } else if self.tag == 3 {
            // use this tag to add seperator line
       //     self.backgroundColor = UIColor.seperatorLightColor
       //
        } else{
            self.font = UIFont(name: AppFont.regular, size: updateFont)
        }
    }
    
    //for calcuale the label size according to it's text.
    static func labelSize(for attributedText: NSAttributedString, considering maxWidth: CGFloat) -> CGSize {
        let constraintBox = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let rect = attributedText.boundingRect(with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).integral
        
        return rect.size
    }
}
