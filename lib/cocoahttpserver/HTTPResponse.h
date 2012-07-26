#import <Foundation/Foundation.h>

#define HTTPResponse Franks_HTTPResponse
#define HTTPFileResponse Franks_HTTPFileResponse
#define HTTPDataResponse Franks_HTTPDataResponse

@protocol HTTPResponse

- (UInt64)contentLength;

- (UInt64)offset;
- (void)setOffset:(UInt64)offset;

- (NSData *)readDataOfLength:(unsigned int)length;

@end

@interface HTTPFileResponse : NSObject <HTTPResponse>
{
	NSString *filePath;
	NSFileHandle *fileHandle;
}

- (id)initWithFilePath:(NSString *)filePath;
- (NSString *)filePath;

@end

@interface HTTPDataResponse : NSObject <HTTPResponse>
{
	unsigned offset;
	NSData *data;
}

- (id)initWithData:(NSData *)data;

@end
