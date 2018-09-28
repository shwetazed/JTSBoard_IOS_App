//
//  CurrencyTextField.swift
//  JTSBoard
//
//  Created by jts on 08/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {

    var string: String { return text ?? "" }
    var decimal: Decimal {
        return string.digits.decimal /
            Decimal(pow(10, Double(Formatter.currency.maximumFractionDigits)))
    }
    var decimalNumber: NSDecimalNumber { return decimal.number }
    var doubleValue: Double { return decimalNumber.doubleValue }
    var integerValue: Int { return decimalNumber.intValue   }
    let maximum: Decimal = 999_999_999.99
    private var lastValue: String = ""
    override func willMove(toSuperview newSuperview: UIView?) {
        // you can make it a fixed locale currency if if needed
        // Formatter.currency.locale = Locale(identifier: "pt_BR") // or "en_US", "fr_FR", etc
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .left
        editingChanged()
    }
    override func deleteBackward() {
        text = string.digits.dropLast().string
        editingChanged()
    }
    @objc func editingChanged() {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        lastValue = Formatter.currency.string(for: decimal) ?? ""
        text = lastValue
        print("integer:", integerValue)
        print("double:", doubleValue)
        print("decimal:", decimal)
        print("currency:", lastValue)
    }
   }

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = .currency
        self.currencySymbol = "¥"
        //self.locale = Locale(identifier: "es_CL")
        self.decimalSeparator = "."
        self.groupingSeparator = ","

        self.locale = Locale(identifier: "es_ES")

    }
}
extension Formatter {
    static let currency = NumberFormatter(numberStyle: .currency)
}
extension String {
    var digits: [UInt8] { return self.compactMap{ UInt8(String($0)) } }
}
extension Collection where Iterator.Element == UInt8 {
    var string: String { return map(String.init).joined() }
    var decimal: Decimal { return Decimal(string: string) ?? 0 }
}
extension Decimal {
    var number: NSDecimalNumber { return NSDecimalNumber(decimal: self) }
}
