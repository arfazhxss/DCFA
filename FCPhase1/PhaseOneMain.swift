//
//  Test001.swift
//  Compound Interest Calculator
//
//  Created by Arfaz Hussain on 2023-04-15.
//

import Charts
import SwiftUI

struct PhaseOneMain: View {
    @State var showSheet1: Bool = false
    @State var showSheet2: Bool = false
    @State var initialInvestment: Float = 0
    @State var AnnualInterestRate: Float = 0.0
    @State var regContributions: Float = 0.0
    @State var regCType: String = "nil"
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
                    .onReceive([selectedOption].publisher.first()) { value in
                            if value == "Weekly" {
                                regCType = "Weekly"
                            }
                        }
                    Toggle(isOn: Binding<Bool>(
                        get: { selectedOption == "Monthly" },
                        set: { if $0 { selectedOption = "Monthly" } }
                    )) {
                        Text("Monthly")
                    }
                    .onReceive([selectedOption].publisher.first()) { value in
                            if value == "Weekly" {
                                regCType="Monthly"
                            }
                        }
                    Toggle(isOn: Binding<Bool>(
                        get: { selectedOption == "Yearly" },
                        set: { if $0 { selectedOption = "Yearly" } }
                    )) {
                        Text("Yearly")
                    }
                    .onReceive([selectedOption].publisher.first()) { value in
                            if value == "Weekly" {
                                regCType="Yearly"
                            }
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
                        SecondScreen(
                            initialInvestment: self.initialInvestment,
                            AnnualInterestRate: self.AnnualInterestRate,
                            yearsToGrow: self.yearsToGrow,
                            regContributions: self.regContributions,
                            regCType: self.regCType
                        )
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
    var regCType: String
    
    var test1: Float = 0
    var test2: Float = 0
    
    init(initialInvestment: Float, AnnualInterestRate: Float, yearsToGrow: Int, regContributions: Float, regCType: String) {
        self.initialInvestment = initialInvestment
        self.AnnualInterestRate = AnnualInterestRate
        self.yearsToGrow = yearsToGrow
        self.regContributions = regContributions
        self.regCType = regCType

        // SWITCH CASE FOR REGCTYPE : WEEKLY OR MONTHLY OR YEARLY, CHANGING THE VALUE OF N
        // Different types of regular contributions
        let n: Float // Number of times interest is applied in a year
        switch regCType {
            case "Weekly":
                n = 52 // 52 weeks in a year
            case "Monthly":
                n = 12 // 12 months in a year
            case "Yearly":
                n = 1 // Interest applied yearly
            default:
                n = 1 // Default to yearly
        }
    
        let t: Int = self.yearsToGrow
        let r: Float = self.AnnualInterestRate / 100
        let i = pow(1 + r, 1 / n) - 1
                                                                                        // Discounted Cash Flow Analysis (DCFA)
        let A1 = initialInvestment * pow(1 + r, Float(t))                               // F = P x (F/P,i,N)
        let A2 = regContributions * ((pow(1 + (i), (n*Float(t))) - 1) / (i))    // F = A x (F/A,i,N)
        test1 = A1
        test2 = A2

        self.finalAmount = A1 + A2
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
                        Text("A1: \(String(format: "%.2f", (test1)))")
                            .frame(maxWidth: 400, alignment: .leading)
                        Text("A2: \(String(format: "%.2f", (test2)))")
                            .frame(maxWidth: 400, alignment: .leading)
                        Spacer().frame(height: 50)
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
        //PhaseOneMain()
        SecondScreen(initialInvestment: 4200.00, AnnualInterestRate: 50.00, yearsToGrow: 7, regContributions: 1, regCType: "Yearly")
    }
}
