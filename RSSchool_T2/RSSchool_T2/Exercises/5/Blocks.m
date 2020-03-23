#import "Blocks.h"

@interface Blocks()

@property (nonatomic) NSArray *array;
@property (nonatomic) Class class;

@end

@implementation Blocks

-(instancetype)init {
    if (self = [super init])  {
        
        __weak Blocks *weakSelf = self;
        
        self.blockA = ^(NSArray *array) {
            Blocks *strongSelf = weakSelf;
            strongSelf.array = array;
        };
        
        self.blockB = ^(Class class) {
            Blocks *strongSelf = weakSelf;
            strongSelf.class = class;
        };
    }
    return self;
}

- (void)setArray:(NSArray *)array {
    _array = array;
    [self runBlockCIfInafData];
}

- (void)setClass:(Class)class {
    _class = class;
    [self runBlockCIfInafData];
}

- (void)runBlockCIfInafData {
    if (self.array && self.class) {
        if (self.class == NSString.class) {
            NSMutableString * result = [[NSMutableString alloc] init];
            for (NSObject * obj in self.array) {
                if ([obj isKindOfClass:NSString.class]) {
                    [result appendString:[obj description]];
                }
            }

            self.blockC(result);
        }
        else if (self.class == NSNumber.class) {
           NSNumber * result = [[NSNumber alloc] init];
            for (NSObject * obj in self.array) {
                if ([obj isKindOfClass:NSNumber.class]) {
                   result = @(result.integerValue + ((NSNumber*)obj).integerValue) ;
                }
            }

            self.blockC(result);
        } else if (self.class == NSDate.class) {
            NSDate * result = [NSDate distantPast];
            for (NSObject * obj in self.array) {
                if ([obj isKindOfClass:NSDate.class]) {
                    NSComparisonResult compResult = [result compare:(NSDate*)obj];
                    if (compResult == NSOrderedAscending) {
                        result = (NSDate*)obj;
                    }
                }
            }
            
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat: @"dd.MM.yyyy"];
            
            self.blockC([formatter stringFromDate:result]);
        }
    }
}


@end

