#import "ImageModel.h"

@interface ImageModel ()

@property (strong, nonatomic) NSArray *imageNames;
@property (strong, nonatomic) NSDictionary *imagesDict;

@end

@implementation ImageModel

+ (ImageModel *)sharedInstance {
    static ImageModel *_sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[ImageModel alloc] init];
    });
    return _sharedInstance;
}

- (NSArray *)imageNames {
    if (!_imageNames) {
        _imageNames = @[@"Bill", @"Eric", @"Jeff", @"Cam", @"Ephraim", @"Naim"];
    }
    return _imageNames;
}

- (NSDictionary *)imagesDict {
    if (!_imagesDict) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (NSString *name in self.imageNames) {
            UIImage *image = [UIImage imageNamed:name];
            if (image) {
                dict[name] = image;
            } else {
                NSLog(@"Failed to load image: %@", name);
            }
        }
        _imagesDict = [NSDictionary dictionaryWithDictionary:dict];
    }
    return _imagesDict;
}

- (UIImage *)getImageWithName:(NSString *)name {
    return self.imagesDict[name];
}

- (UIImage *)getImageWithIndex:(NSInteger)index {
    if (index >= 0 && index < self.imageNames.count) {
        NSString *name = self.imageNames[index];
        return [self getImageWithName:name];
    }
    return nil;
}

- (NSInteger)numberOfImages {
    return self.imageNames.count;
}

- (NSString *)getImageNameForIndex:(NSInteger)index {
    if (index >= 0 && index < self.imageNames.count) {
        return self.imageNames[index];
    }
    return nil;
}

@end
