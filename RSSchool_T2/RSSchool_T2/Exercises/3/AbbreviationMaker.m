#import "AbbreviationMaker.h"

@implementation AbbreviationMaker
// Complete the abbreviation function below.
- (NSString *) abbreviationFromA:(NSString *)a toB:(NSString *)b {
    
    NSMutableArray *arrayA = [self getFromString: a];
    NSMutableArray *arrayB = [self getFromString: b];
    NSArray *arrayToCompare = arrayB.copy;
    
    for (NSInteger i = arrayA.count - 1; i >= 0; i--) {
        NSString *elementA = arrayA[i];
        if (arrayB.count > 0) {
            NSString *elementB = arrayB[arrayB.count-1];
            
            NSString *elementAUppercased = elementA.uppercaseString;
            
            if ([elementAUppercased isEqual: elementB]) {
                arrayA[i] = elementAUppercased;
                [arrayB removeObjectAtIndex: arrayB.count-1];
                
                continue;
            }
        }
        [arrayA removeObjectAtIndex:i];
    }
    
    return [arrayA isEqual: arrayToCompare] ? @"YES" : @"NO";
}

- (NSMutableArray *)getFromString:(NSString *) string {
    
    NSMutableArray  *chars = [NSMutableArray array];
    NSUInteger      len = [string length];
    unichar         buffer[len+1];
    
    [string getCharacters: buffer range: NSMakeRange(0, len)];
    for (int i=0; i<len; i++) {
        [chars addObject: [NSString stringWithFormat: @"%C", buffer[i]]];
    }
    
    return chars;
}

@end
