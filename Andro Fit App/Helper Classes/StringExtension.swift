//
//  StringExtension.swift
//  StudioSpaceApp
//
//  Created by Rajni Bajaj on 20/01/22.
//

import Foundation

extension String {

    func validateEmailId(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    //    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       // return applyPredicateOnRegex(regexStr: emailRegEx)
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

     func validatePassword() -> Bool {
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
    func applyPredicateOnRegex(regexStr: String)    -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
            let validateOtherString = NSPredicate(format: "self Matches %@", regexStr)
            let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
 
            return isValidateOtherString
     }
  
        var isAlphanumeric: Bool {
            return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
        }
    
    
}

