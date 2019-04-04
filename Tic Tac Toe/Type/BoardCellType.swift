//
//  CellType.swift
//  Tic Tac Toe
//
//  Created on 03/04/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation

enum BoardCellType: String {
    
    case zero, x, none
    
    var value: String {
        switch self {
        case .zero:
            return "O"
        case .x:
            return "X"
        case .none:
            return " "
        }
    }
    
    var antiState: BoardCellType {
        switch self {
        case .zero, .none:
            return .x
        case .x:
            return .zero
        }
    }
}
