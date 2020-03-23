#import "NSString+Transform.h"

typedef enum LeeterType {
    Vowels,
    Consonants
} LeeterType;

@implementation NSString (Transform)

NSString *const VowelsLetters = @"aeiouy";

NSString *const ConsonansLetters = @"bcdfghjklmnpqrstvxwz";

-(NSString*)transform {
    
    LeeterType type = [self isPangram] ? Vowels : Consonants;
    
    NSMutableArray *words = [self wordsFormString];
    
    words = [self capitalizeLettersType:type array: words];
    
    words =  [self addQuanityOfLetterType:type array: words];
    
    words = [self sotrArray: words];
    
    self = [[words valueForKey:@"description"] componentsJoinedByString:@" "];

    return self;
}

-(BOOL)isPangram {
    
    NSString *string = [self lowercaseString];
    NSMutableCharacterSet *set = [NSMutableCharacterSet whitespaceCharacterSet];
    [set formUnionWithCharacterSet:[NSMutableCharacterSet punctuationCharacterSet]];
    
    string = [[string componentsSeparatedByCharactersInSet:set]componentsJoinedByString:@""];
    
//    if([string rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location!=NSNotFound) {
//        return false;
//    }
    
    NSMutableSet<NSString *> *alphabets = [NSMutableSet set];
    for(int i=0;i<string.length;i++){
        if([string characterAtIndex:i] >= 'a' && [string characterAtIndex:i]<='z')
            [alphabets addObject:[NSString stringWithFormat:@"%c",[string characterAtIndex:i]]];
    }
    
    if([alphabets count] < 26) {
        return false;
    }
    
    return true;
}

-(NSMutableArray *)wordsFormString {
    NSArray *array = [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    return array.mutableCopy;
}

-(NSMutableArray *)capitalizeLettersType:(LeeterType) type array:(NSMutableArray *) array {
    NSMutableArray *resultArray = [NSMutableArray new];
    for (NSString* word in array) {
        NSUInteger len = [word length];
        unichar buffer[len+1];
        
        [word getCharacters:buffer range:NSMakeRange(0, len)];
        
        for(int i = 0; i < len; i++) {
            
            NSString * letter = [NSString stringWithFormat: @"%C", buffer[i]];
            BOOL isConsonants = [ConsonansLetters containsString: letter.lowercaseString];
            BOOL isVolwes = [VowelsLetters containsString: letter.lowercaseString];
            
            switch(type){
                case Vowels:
                    if (isVolwes) {
                        word = [word stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString: letter.uppercaseString];
                    }
                    break;
                case Consonants:
                    if (isConsonants) {
                       word = [word stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString: letter.uppercaseString];
                    }
                    break;
            }
        }
        [resultArray addObject:word];
    }
    
    return resultArray;
}

-(NSMutableArray*)addQuanityOfLetterType:(LeeterType) type array:(NSMutableArray *) array {
    NSMutableArray *resultArray = [NSMutableArray new];
    for (NSString* word in array) {
        NSUInteger len = [word length];
        unichar buffer[len+1];
        
        [word getCharacters:buffer range:NSMakeRange(0, len)];
        
        int numberOfLetters = 0;
        
        for(int i = 0; i < len; i++) {
            
            NSString * letter = [NSString stringWithFormat: @"%C", buffer[i]];
            BOOL isConsonants = [ConsonansLetters containsString: letter.lowercaseString];
            BOOL isVolwes = [VowelsLetters containsString: letter.lowercaseString];
            
            
            switch(type){
                case Vowels:
                    if (isVolwes) {
                        numberOfLetters++;
                    }
                    break;
                case Consonants:
                    if (isConsonants) {
                        numberOfLetters++;
                    }
                    break;
            }
        }
        
        [resultArray addObject: [NSString stringWithFormat:@"%ld%@", (long)numberOfLetters, word]];
    }
    
    return resultArray;
}

-(NSMutableArray*)sotrArray:(NSMutableArray*) array {
    NSArray *sortedArray;
    sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *i = [a substringToIndex:1];
        NSString *j = [b substringToIndex:1];
      
        return [i intValue] > [j intValue];
    }];
    
    return sortedArray.mutableCopy;
}

@end
