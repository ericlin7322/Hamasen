//
//  PhoneBook.swift
//  Hamasen
//
//  Created by Eric Lin on 2019/1/9.
//  Copyright © 2019 Eric Lin. All rights reserved.
//

import UIKit

class PhoneBook: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        
    }
}


