//
//  ContentView.swift
//  MortgageCalculator
//
//  Created by Hasindu Mendis on 2023-03-23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("monthlyPaymentS") var monthlyPaymentS: String = "583.51"
    @AppStorage("loanPeriodS") var loanPeriodS: String = "25"
    @AppStorage("interestRateS") var interestRateS: String = "4"
    @AppStorage("finalAmount") var finalAmount: String = "30000"
    
    @State private var displyMode = false
    
    var body: some View {
        
        ZStack{
            
            Image("house")
                .resizable()
                .frame(width: 200, height: 200)
                .opacity(0.5)
            
            
            ScrollView{
                
                VStack(spacing: 20) {

                    VStack{
                        
                        
                        Text("Mortgage Calculator")
                            .bold()
                            .font(.title)
                        
                        HStack{
                            Image(systemName: "sterlingsign.circle.fill")
                            Text ("Monthly Payment")
                        }
                        
                        TextField("30000" ,text: $monthlyPaymentS)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                            .onChange(of: monthlyPaymentS){ value in  // to display and hide data
                               monthlyPaymentS = checkText(text: value)
                            }
                        
                        HStack{
                            Image(systemName: "clock.badge.questionmark")
                            Text ("Loan Period - Year")
                        }
                        
                        TextField("25" ,text: $loanPeriodS)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                            .onChange(of: loanPeriodS){ value in  // to display and hide data
                                loanPeriodS = checkText(text: value)
                            }
                        
                        HStack{
                            Image(systemName: "percent")
                            Text ("Interest Rate")
                        }
                        
                        TextField("4" ,text: $interestRateS)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                            .onChange(of: interestRateS){ value in  // to display and hide data
                                interestRateS = checkText(text: value)
                            }
                        
                    }
                    
                    
                    VStack(spacing: 20){
                        Button {
                            mortgageCalculation()
                            displyMode = true
                        } label: {
                            Text("Calculate")
                        }
                        
                        if displyMode {
                            Text("Amount that can be brrowed:  \(finalAmount)")
                        }
                    }
                    
                }
                
                
            }
        }

        

    }
    
    func checkText(text:String)->String{ var updatedString = text
        var dotCount = 0
        for d in text {
            if String(d) == "."
            { dotCount += 1 } }
        if dotCount >= 2 {
            // remove the last typed point updatedString = String(text.dropLast())
        }
        return updatedString }
    
    
    func mortgageCalculation(){
        
        guard let monthlyPayment = Double(monthlyPaymentS),
              let interestRate = Double(interestRateS),
              let loanPeriod = Double(loanPeriodS) else {return}
        
        let valueR = interestRate / 100
        let valueA = (valueR / 12) + 1
        let valueN = Double(loanPeriod * 12)
            
        let valueX = pow(valueA, valueN) - 1
        let valueY = pow(valueA, -valueN)
            
        let upper = monthlyPayment * (valueX * valueY)
        let amount = upper / (valueR/12)
        
        finalAmount = String(format: "%.2f", amount)
        
        print(amount)
        print(finalAmount)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
