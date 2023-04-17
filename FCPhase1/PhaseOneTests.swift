//
//  test.swift
//  Compound Interest Calculator
//
//  Created by Arfaz Hussain on 2023-04-16.
//

import SwiftUI


struct PhaseOneTests: View {
    @State private var selectedOption: String? = nil
    
    var body: some View {
        VStack {
            Toggle(isOn: Binding<Bool>(
                get: { selectedOption == "Weekly" },
                set: { if $0 { selectedOption = "Weekly" } }
            )) {
                Text("Weekly")
            }
            Toggle(isOn: Binding<Bool>(
                get: { selectedOption == "Monthly" },
                set: { if $0 { selectedOption = "Monthly" } }
            )) {
                Text("Monthly")
            }
            Toggle(isOn: Binding<Bool>(
                get: { selectedOption == "Yearly" },
                set: { if $0 { selectedOption = "Yearly" } }
            )) {
                Text("Yearly")
            }
        }.padding(130)
        
    }
    
    
    struct test_Previews: PreviewProvider {
        static var previews: some View {
            test()
        }
    }
}
