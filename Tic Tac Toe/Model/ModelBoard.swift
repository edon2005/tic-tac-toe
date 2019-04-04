//
//  ModelBoard.swift
//  Tic Tac Toe
//
//  Created on 04/04/2019.
//  Copyright © 2019 Yevhen Don. All rights reserved.
//

import Foundation

class ModelBoard {
    var grid = [[BoardCellType]]()
    
    init () {
        //Build grid 3x3
        (0...2).forEach {_ in
            var row = [BoardCellType]()
            (0...2).forEach {_ in
                row.append(.none)
            }
            grid.append(row)
        }
    }
    
    //check whteher grid has winner situation
    func isWinner(_ step: BoardCellType) -> Bool {
        
        var result: Bool
        
        //Check horizontal row for fullfilling all cell with the same type
        result = grid
            .map {
                $0.reduce(true) {
                    $0 && ($1 == step)
                }
            }
            .contains(true)
        
        if result == true {
            return result
        }

        //Check vertical row for fullfilling all cell with the same type
        for j in 0...2 {
            result = true
            for i in 0...2 {
                result = result && (grid[i][j] == step)
            }
            if result == true {
                return true
            }
        }
        
        //Check diagonal for winner situtation
        result = [0,1,2].reduce(true) {
            $0 && (grid[$1][$1] == step)
        }

        if result == true {
            return result
        }
        
        //Check opposite diagonal for winner situtation
        result = [2,1,0].enumerated().reduce(true) {
            $0 && (grid[$1.offset][$1.element] == step)
        }

        return result
    }
    
    //whether grid has empty cell
    func isEmptyCell() -> Bool {
        return grid.flatMap({$0}).filter({$0 == .none}).count > 0
    }
}
