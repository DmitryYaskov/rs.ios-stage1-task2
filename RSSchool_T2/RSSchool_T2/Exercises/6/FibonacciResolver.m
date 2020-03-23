#import "FibonacciResolver.h"

@implementation FibonacciResolver
- (NSArray*)productFibonacciSequenceFor:(NSNumber*)number {
    
    int curr = 1, prev = 1, targetValue = number.intValue;
    
    while (targetValue > curr * prev) {
        curr += prev;
        prev = curr-prev;
    }
    
    return @[@(prev), @(curr), @(curr * prev == targetValue ? 1 : 0)];
}
@end
