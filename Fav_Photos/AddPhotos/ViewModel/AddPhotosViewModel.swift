//
//  AddPhotosViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import Foundation
class AddPhotosViewModel {
func  getCurrentTime() -> String {

    let date = Date()
    let calendar = Calendar.current


    let year = calendar.component(.year, from: date)
    var month = "\(calendar.component(.month, from: date))"
    let day = calendar.component(.day, from: date)
    switch month {
    case "1" :
     month =  "JAN"
    case "2" :
        month = "FEB"
    case "3" :
        month = "MAR"
    case "4" :
        month = "APR"
    case "5" :
        month = "MAY"
    case "6" :
        month = "JUN"
    case "7" :
        month = "JUL"
    case "8" :
        month = "AUG"
    case "9" :
        month = "SEPT"
    case "10" :
        month = "OCT"
    case "11" :
        month = "NOV"
    default:
        month = "DEC"
    }
    
    let realTime = "\(year)-\(month)-\(day)"

    return realTime
}
}
