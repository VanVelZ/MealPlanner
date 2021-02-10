//
//  DecimalField.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/3/21.
//

import SwiftUI
import Combine

struct DecimalField : View {
    
    let label: LocalizedStringKey
    @Binding var value: Double?
    let formatter: NumberFormatter
    let onEditingChanged: (Bool) -> Void
    let onCommit: () -> Void
    
    // The formatter that formats the editing string.
    private let editStringFormatter: NumberFormatter
    
    // The text shown by the wrapped TextField. This is also the "source of
    // truth" for the `value`.
    @State private var textValue: String = ""
    
    // When the view loads, `textValue` is not synced with `value`.
    // This flag ensures we don't try to get a `value` out of `textValue`
    // before the view is fully initialized.
    @State private var hasInitialTextValue = false
    
    init(
        _ label: LocalizedStringKey,
        value: Binding<Double?>,
        formatter: NumberFormatter,
        onEditingChanged: @escaping (Bool) -> Void = { _ in },
        onCommit: @escaping () -> Void = {}
    ) {
        self.label = label
        self._value = value
        self.formatter = formatter
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        
        // We configure the edit string formatter to behave like the
        // input formatter without add the currency symbol,
        // percent symbol, etc...
        self.editStringFormatter = NumberFormatter()
        self.editStringFormatter.allowsFloats = formatter.allowsFloats
        self.editStringFormatter.alwaysShowsDecimalSeparator = formatter.alwaysShowsDecimalSeparator
        self.editStringFormatter.decimalSeparator = formatter.decimalSeparator
        self.editStringFormatter.maximumIntegerDigits = formatter.maximumIntegerDigits
        self.editStringFormatter.maximumSignificantDigits = formatter.maximumSignificantDigits
        self.editStringFormatter.maximumFractionDigits = formatter.maximumFractionDigits
        self.editStringFormatter.multiplier = formatter.multiplier
    }
    
    var body: some View {
        TextField(label, text: $textValue, onEditingChanged: { isInFocus in
            // When the field is in focus we replace the field's contents
            // with a plain specifically formatted number. When not in focus, the field
            // is treated as a label and shows the formatted value.
            if isInFocus {
                let newValue = self.formatter.number(from: self.textValue)
                self.textValue = self.editStringFormatter.string(for: newValue) ?? ""
            } else {
                let f = self.formatter
                let newValue = f.number(from: self.textValue)?.decimalValue
                self.textValue = f.string(for: newValue) ?? ""
            }
            self.onEditingChanged(isInFocus)
        }, onCommit: {
            self.onCommit()
        })
            .onReceive(Just(textValue)) {
                guard self.hasInitialTextValue else {
                    // We don't have a usable `textValue` yet -- bail out.
                    return
                }
                // This is the only place we update `value`.
                self.value = self.formatter.number(from: $0)?.doubleValue
        }
            .onAppear(){ // Otherwise textfield is empty when view appears
                self.hasInitialTextValue = true
                // Any `textValue` from this point on is considered valid and
                // should be synced with `value`.
                if let value = self.value {
                    // Synchronize `textValue` with `value`; can't be done earlier
                    self.textValue = self.formatter.string(from: NSDecimalNumber(decimal: Decimal(value))) ?? ""
                }
        }
        .keyboardType(.decimalPad)
    }
}
