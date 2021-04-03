//
//  Model.swift
//  RPNCalculator
//
//  Created by Samuel Goodwin on 4/3/21.
//

import Foundation

class Model {
    private let cells: [[String]]

    var rows: Int {
        return cells.count
    }

    var columns: Int {
        return cells[0].count
    }

    func value(at: IndexPath) -> String {
        cells[at.section][at.row]
    }

    init(input: String) {

        func pass(_ input: [[String]]) -> ([[String]], Bool) {
            let engine = MathEngine()
            let output = input.map({ row in
                row.map(engine.parse)
            })

            return (output, output.filter({ row in
                return row.contains(where: { Double($0) == nil })
            }).count > 0)
        }

        func substituteReferences(_ input: [[String]]) -> [[String]] {
            input.map({ row in
                row.map({ item in
                    if Double(item) == nil && item.count == 2 {
                        let column = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"].firstIndex(of: item.lowercased().first!)!
                        let row = Int(String(item.last!))!-1
                        return input[column][row]
                    } else {
                        return item
                    }
                })
            })
        }

        var containsReference = true
        var newCells = input.split(separator: "\n").map { row in
            row.split(separator: ",")
            .map(String.init)
        }

        while containsReference {
            (newCells, containsReference) = pass(newCells)
            newCells = substituteReferences(newCells)
        }
        self.cells = newCells
    }
}
