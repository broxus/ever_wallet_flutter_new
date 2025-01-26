#import "SentryClient.h"
#import "SentryDataCategory.h"
#import "SentryDiscardReason.h"

@class SentrySession, SentryEnvelopeItem, SentryId, SentryAttachment, SentryThreadInspector,
    SentryReplayEvent, SentryReplayRecording, SentryEnvelope;

NS_ASSUME_NONNULL_BEGIN

@protocol SentryClientAttachmentProcessor <NSObject>

- (nullable NSArray<SentryAttachment *> *)processAttachments:
                                              (nullable NSArray<SentryAttachment *> *)attachments
                                                    forEvent:(SentryEvent *)event;

@end

@interface SentryClient ()

@property (nonatomic, strong)
    NSMutableArray<id<SentryClientAttachmentProcessor>> *attachmentProcessors;
@property (nonatomic, strong) SentryThreadInspector *threadInspector;
@property (nonatomic, strong) SentryFileManager *fileManager;

- (SentryId *)captureError:(NSError *)error
                 withScope:(SentryScope *)scope
    incrementSessionErrors:(SentrySession * (^)(void))sessionBlock;

- (SentryId *)captureException:(NSException *)exception
                     withScope:(SentryScope *)scope
        incrementSessionErrors:(SentrySession * (^)(void))sessionBlock;

- (SentryId *)captureCrashEvent:(SentryEvent *)event withScope:(SentryScope *)scope;

- (SentryId *)captureCrashEvent:(SentryEvent *)event
                    withSession:(SentrySession *)session
                      withScope:(SentryScope *)scope;

- (void)saveCrashTransaction:(SentryTransaction *)transaction
                   withScope:(SentryScope *)scope
    NS_SWIFT_NAME(saveCrashTransaction(transaction:scope:));

- (SentryId *)captureEvent:(SentryEvent *)event
                  withScope:(SentryScope *)scope
    additionalEnvelopeItems:(NSArray<SentryEnvelopeItem *> *)additionalEnvelopeItems
    NS_SWIFT_NAME(capture(event:scope:additionalEnvelopeItems:));

- (void)captureReplayEvent:(SentryReplayEvent *)replayEvent
           replayRecording:(SentryReplayRecording *)replayRecording
                     video:(NSURL *)videoURL
                 withScope:(SentryScope *)scope;

- (void)captureSession:(SentrySession *)session NS_SWIFT_NAME(capture(session:));

/**
 * Needed by hybrid SDKs as react-native to synchronously store an envelope to disk.
 */
- (void)storeEnvelope:(SentryEnvelope *)envelope;

- (void)captureEnvelope:(SentryEnvelope *)envelope;

- (void)recordLostEvent:(SentryDataCategory)category reason:(SentryDiscardReason)reason;
- (void)recordLostEvent:(SentryDataCategory)category
                 reason:(SentryDiscardReason)reason
               quantity:(NSUInteger)quantity;

- (void)addAttachmentProcessor:(id<SentryClientAttachmentProcessor>)attachmentProcessor;
- (void)removeAttachmentProcessor:(id<SentryClientAttachmentProcessor>)attachmentProcessor;

@end

NS_ASSUME_NONNULL_END
