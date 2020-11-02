

import Foundation


// 10/04/2020 14:00:00
//let staticDate: TimeInterval = 1_586_516_400
let staticDate: TimeInterval = 1_586_507_700
let threeDays: TimeInterval =  259_200
//172800
//82800

import Foundation

class TimerManager {
    
    var totalSeconds: TimeInterval = 259200
    var timer: Timer?

    private init() {
        totalSeconds = setIntervalCount()
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    static let shared = TimerManager()
    
    func setIntervalCount() -> TimeInterval {
        
        let nextUpdate: TimeInterval = staticDate
        let currentDate: TimeInterval = Date().timeIntervalSince1970
        
        var duration = nextUpdate - currentDate
        
        if duration <= threeDays && duration > 0 {
            
            // апдейт будет менее чем через 3 дня
            //return duration
        } else {
            
            var dateNextUpdate = Date(timeIntervalSince1970: staticDate)
            while duration < 0 {

                dateNextUpdate.day(dateNextUpdate.day + 3)
                duration = dateNextUpdate.timeIntervalSince1970 - currentDate
                
            }
            print("🥮 \(dateNextUpdate) 🥮")
        }
    
        return duration
    }
    
    @objc func timerAction() {
        if totalSeconds <= 0 {
            totalSeconds = setIntervalCount()
        }
        totalSeconds -= 1
        _ = format(totalSeconds: totalSeconds)
    }
    
    func format(totalSeconds total: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated // Use the appropriate positioning for the current locale
        formatter.allowedUnits = [ .day, .hour, .minute, .second ] // Units to display in the formatted string
        
        formatter.zeroFormattingBehavior = [ .pad ] // Pad with zeroes where appropriate for the locale

        let formattedDuration = formatter.string(from: total)
        return formattedDuration ?? ""
    }
    
}
