//
//  LabelCell.swift
//  Tic Tac Toe
//
//  Created on 04/04/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class LabelCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(label)
        label.easy.layout(Edges(5))
        contentView.backgroundColor = .white
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 70)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
