//
//  Test001.swift
//  Compound Interest Calculator
//
//  Created by Arfaz Hussain on 2023-04-15.
//

import SwiftUI

struct Test001: View {
    @State var showSheet1: Bool = false
    @State var showSheet2: Bool = false
    @State var initialInvestment: Float = 0
    @State var AnnualInterestRate: Float = 0.0
    @State var regContributions: Float = 0.0
//    @State var regCType: String = "Yearly"
    @State var yearsToGrow: Int = 1
    @State var finalAmount: Float = 0.0
    @State private var selectedOption: String? = nil
    var body: some View {
        NavigationView {
            VStack () {
                Text("Compound")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Interest Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .navigationBarTitleDisplayMode(.large)
                ZStack {
                    Button  (
                        action: {
                            showSheet2.toggle()
                        },
                        label: {
                            Text("Tutorial")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(10)
                                .background(Color.blue.cornerRadius(10))
                        })
                    .sheet(isPresented: $showSheet2, content: {
                        ThirdScreen()
                    })
//                    Spacer()
                }.frame(width: .infinity, height: 100)
//                Spacer().frame(height:10)
                
                VStack {
                    HStack (alignment: .center) {
                        Spacer()
                        Text("Initial Investment: ")
                        Spacer()
                        TextField(">500", value: $initialInvestment, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .background(Color.gray.opacity(0.3).cornerRadius(6))
                            .foregroundColor(.white)
                            .font(.headline)
                        Text("$")
                        Spacer()
                    }
                    HStack (alignment: .center) {
                        Spacer()
                        Text("Annual Interest Rate: ")
                        TextField(">=1", value: $AnnualInterestRate, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .background(Color.gray.opacity(0.3).cornerRadius(6))
                            .foregroundColor(.white)
                            .font(.headline)
                        Text ("%")
                        Spacer()
                    }
                }
                .frame(width:300)
                .padding(10)
                .background(Color.green.opacity(0.5))
                .cornerRadius(10)
                Spacer().frame(maxHeight: 30)
                VStack {
                    Text("Optional Contributions: ").multilineTextAlignment(.center)
                    HStack {
                        TextField("$", value: $regContributions, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .padding()
                            .frame(maxWidth: 200, maxHeight: 30)
                            .background(Color.gray.opacity(0.3).cornerRadius(6))
                            .foregroundColor(.white)
                            .font(.headline)
                        Text ("$")
                    }
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
                }.frame(width:200).padding(10).background(Color.blue.opacity(0.2)).cornerRadius(20)
                Spacer().frame(maxHeight: 30)
                HStack (alignment: .center) {
                    Spacer()
                    Text("Years To Grow: ")
                    TextField(">=1", value: $yearsToGrow, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .padding()
                        .frame(maxWidth: 200, maxHeight: 30)
                        .background(Color.gray.opacity(0.3).cornerRadius(6))
                        .foregroundColor(.white)
                        .font(.headline)
                    Text ("$")
                    Spacer()
                }
                ZStack (alignment: .center) {
                    Button  (
                        action: {
                            if calculationValidation() {
                                showSheet1.toggle()
                            }
                        },
                        label: {
                            Text("Calculate")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(10)
                                .background(calculationValidation() ? Color.blue.cornerRadius(10) : Color.gray.cornerRadius(10))
                        })
                    .sheet(isPresented: $showSheet1, content: {
                        SecondScreen(initialInvestment: self.initialInvestment, AnnualInterestRate: self.AnnualInterestRate, yearsToGrow: self.yearsToGrow, regContributions: self.regContributions)
                    })
                    Spacer()
                }.frame(width: .infinity, height: 100)
            }
        }
    }
    
    func calculationValidation () -> Bool {
        if ((initialInvestment>=1000)&&(AnnualInterestRate>=1)) {return true}
        return false;
    }
}

struct SecondScreen: View {
    @Environment(\.presentationMode) var presentationMode
    var initialInvestment: Float
    var AnnualInterestRate: Float
    var yearsToGrow: Int
    var regContributions: Float
    var finalAmount: Float

//    init(initialInvestment: Float, AnnualInterestRate: Float, yearsToGrow: Int, regContributions: Float) {
//        self.initialInvestment = initialInvestment
//        self.AnnualInterestRate = AnnualInterestRate
//        self.yearsToGrow = yearsToGrow
//        let n: Float = 1 // interest applied yearly
//        let A1 = initialInvestment * pow(1 + AnnualInterestRate / (n * 100), n * Float(yearsToGrow))
//
//        self.finalAmount = A1
//        }
    init(initialInvestment: Float, AnnualInterestRate: Float, yearsToGrow: Int, regContributions: Float) {
            self.initialInvestment = initialInvestment
            self.AnnualInterestRate = AnnualInterestRate
            self.yearsToGrow = yearsToGrow
            self.regContributions = regContributions

            let n: Float = 1 // interest applied yearly
            let t: Int = self.yearsToGrow
            let r: Float = self.AnnualInterestRate / 100

            let A1 = initialInvestment * pow(1 + r / n, n * Float(t))
            let A2 = regContributions * pow((1 + r / n),((n * Float(t)) - 1) / (r / n))

            self.finalAmount = A1 + A2
             //self.finalAmount = A1
        }
    
    var body: some View {
            ZStack (alignment: .topLeading) {
                Color.blue.opacity(0.7).edgesIgnoringSafeArea(.all)
                Button (
                    action: {
                        presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding(20)
                    })
                
                HStack (alignment:.center){
                    Spacer().frame(width: 100)
                    VStack (alignment: .trailing) {
                        Spacer()
                        Text("Principal Invested: \(String(format: "%.2f", (initialInvestment)))")
                            .frame(maxWidth: 400, alignment: .leading)
                        Text("Interest Gained: \(String(format: "%.2f", (finalAmount - initialInvestment)))")
                            .frame(maxWidth: 400, alignment: .leading)
                        Text("Total: \(String(format: "%.2f", finalAmount))")
                            .frame(maxWidth: 400, alignment: .leading)
                        Spacer()
                    }
                }
        }
    }
}

struct ThirdScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ZStack (alignment: .topLeading) {
                Color.white.opacity(0.7).edgesIgnoringSafeArea(.all)
                Button (
                    action: {
                        presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding(20)
                    })
                
                VStack (alignment: .center) {
                    Spacer()
                    Text("Work In Progress")
                        .frame(maxWidth: 400)
                    Spacer()
                }
        }
    }
}

struct Test001_Previews: PreviewProvider {
    static var previews: some View {
        Test001()
        //SecondScreen(finalAmount: 3500.00)
    }
}
