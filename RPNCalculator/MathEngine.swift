//
//  MathEngine.swift
//  RPNCalculator
//
//  Created by Samuel Goodwin on 4/3/21.
//

import Foundation

struct MathEngine {
    private enum MathToken: Equatable {
        case number(Double)
        case symbol(MathOperator)
        case reference(String)

        var value: Double? {
            switch self {
            case .number(let value):
                return value
            case .symbol:
                return nil
            case .reference:
                return nil
            }
        }

        var cellReference: String? {
            switch self {
            case .number:
                return nil
            case .symbol:
                return nil
            case .reference(let value):
                return value
            }
        }
    }

    private enum MathOperator: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "*"
        case division = "/"
        case exponent = "^"
    }

    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }


    private func lex(_ input: String) -> [MathToken] {
        return input.split(separator: " ").map({
            if let numberValue = Double($0) {
                return .number(numberValue)
            } else if let operation = MathOperator(rawValue: String($0)) {
                return .symbol(operation)
            } else {
                return .reference(String($0))
            }
        })
    }

    private func calculate(_ tokens: [MathToken]) -> String {
        var stack = [MathToken]()
        for token in tokens {
            if case .symbol(let operation) = token {
                if case .number(let b) = stack.popLast(), case .number(let a) = stack.popLast() {
                    switch operation {
                    case .addition:
                        stack.append(.number(a + b))
                    case .subtraction:
                        stack.append(.number(a - b))
                    case .multiplication:
                        stack.append(.number(a * b))
                    case .division:
                        stack.append(.number(a / b))
                    case .exponent:
                        stack.append(.number(pow(a, b)))
                    }
                } else {
                    fatalError("bad input?")
                }
            } else {
                stack.append(token)
            }
        }

        assert(stack.count == 1)

        if let value = stack[0].value {
            return formatter.string(from: NSNumber(value: value)) ?? "#ERR"
        }
        return stack[0].cellReference ?? "#ERR"
    }

    func parse(_ input: String) -> String {
        calculate(lex(input))
    }
}
