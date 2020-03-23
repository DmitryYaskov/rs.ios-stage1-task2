#import "Dates.h"

@implementation Dates

- (NSString *)textForDay:(NSString *)day month:(NSString *)month year:(NSString *)year {
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    [components setCalendar: calendar];
    [components setYear: year.intValue];
    [components setMonth: month.intValue];
    [components setDay: day.intValue];
    [components setTimeZone:[NSTimeZone defaultTimeZone]];
    
    // get date from inner params
    NSDate *date = [calendar dateFromComponents:components];
    
    NSString *dateFormat = @"dd MMMM, EEEE";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"ru_RU"]];
    [dateFormatter setDateFormat: dateFormat];
    
    return [dateFormatter stringFromDate:date];
}

@end
