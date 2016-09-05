//
//  NSDateExtension.swift
//  Quotes
//
//  Created by David Park on 9/4/16.
//  Copyright © 2016 DavidVY. All rights reserved.
//

import Foundation

extension NSDate {
	
	func hour() -> Int {
		//Get Hour
		let calendar = NSCalendar.currentCalendar()
		let components = calendar.components(.Hour, fromDate: self)
		let hour = components.hour
		
		//Return Hour
		return hour
	}
	
	func minute() -> Int {
		//Get Minute
		let calendar = NSCalendar.currentCalendar()
		let components = calendar.components(.Minute, fromDate: self)
		let minute = components.minute
		
		//Return Minute
		return minute
	}
	
	func toShortTimeString() -> String {
		//Get Short Time String
		let formatter = NSDateFormatter()
		formatter.timeStyle = .ShortStyle
		let timeString = formatter.stringFromDate(self)
		
		//Return Short Time String
		return timeString
	}
}