#import "TimeConverter.h"

@implementation TimeConverter
// Complete the following function
- (NSString*)convertFromHours:(NSString*)hours minutes:(NSString*)minutes {
    
    //TODO: Add validation
    
    NSString *postfix = @"";
    int increment = 0;
    
    if (minutes.intValue > 30) {
        minutes = [NSString stringWithFormat:@"%d", 60 - minutes.intValue];
        postfix = @"to";
        increment = 1;
    } else if (minutes.intValue > 1) {
        postfix = @"past";
    }
    
    NSString *hourByWord = [self convertNumberToWord: hours.intValue + increment];
    
    if (minutes.intValue == 0) {
        return [NSString stringWithFormat:@"%@ %@", hourByWord, @"o' clock"];
    } else if (minutes.intValue == 15 ||
               minutes.intValue == 45 ||
               minutes.intValue == 30) {
        
        NSString *minnutesByWord = [self convertNumberToWord: minutes.intValue];
        return [NSString stringWithFormat:@"%@ %@ %@", minnutesByWord, postfix, hourByWord];
    } else {
        
        NSString *firstMinnutesByWord;
        NSString *secondMinnutesByWord = @"";
        NSString *secondLetter = [minutes substringFromIndex:1];
        if (minutes.intValue >= 21) {
             firstMinnutesByWord = [self convertNumberToWord: minutes.intValue];
             secondMinnutesByWord = [self convertNumberToWord: secondLetter.intValue];
                   
        } else {
            firstMinnutesByWord = [self convertNumberToWord: minutes.intValue];
        }
        
        NSString *minuteWord = minutes.intValue == 1 ? @"minute" : @"minutes";
        
        if (secondMinnutesByWord.length > 0) {
           return  [NSString stringWithFormat:@"%@ %@ %@ %@ %@", firstMinnutesByWord, secondMinnutesByWord, minuteWord, postfix, hourByWord];
        } else {
           return [NSString stringWithFormat:@"%@ %@ %@ %@", firstMinnutesByWord, minuteWord, postfix, hourByWord];
        }
    }
    
    return @"";
}

- (NSString*)convertNumberToWord:(NSInteger) number {
    
    switch (number) {
        case 0:
            return @"";
        case 1:
            return @"one";
        case 2:
            return @"two";
        case 3:
            return @"three";
        case 4:
            return @"four";
        case 5:
            return @"five";
        case 6:
            return @"six";
        case 7:
            return @"seven";
        case 8:
            return @"eight";
        case 9:
            return @"nine";
        case 10:
            return @"ten";
        case 11:
            return @"eleven";
        case 12:
            return @"twelve";
        case 13:
            return @"therteen";
        case 14:
            return @"fourteen";
        case 15:
            return @"quarter";
        case 16:
            return @"sixteen";
        case 17:
            return @"seventen";
        case 18:
            return @"eighteen";
        case 19:
            return @"nineteen";
        case 20 ... 29:
            return @"twenty";
        case 30:
            return @"half";
        default:
            return nil;
    }
}
@end
