//
//  AVAssetFrameDecoder.h
//
//  Created by Moses DeJong on 1/4/13.
//
//  License terms defined in License.txt.
//
//  This frame decoder interface will read video frames from an AVAsset which
//  typically means a h264 video attached to the project file. Other file
//  types could be supported by iOS, but currently h264 is the only one that
//  actually works. A Frame decoder interface will load and decompress a
//  specific frame of video using the h264 decoder handware included in iOS.
//  Note that this frame decoder is currently limited in that only 1 frame
//  can be in memory at any one time, the decoder only supports
//  sequential access to frames, and frame can only be decoded once.
//  This frame decoder does not support random access, frame cannot be skipped
//  or repeated and one cannot loop or rewind the decode frame position. This
//  decoder should not be used with a AVAnimatorMedia object, it should only
//  be used to read frames from an asset is a non-realtime blocking usage.

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#import "AVAssetConvertCommon.h"

#import "AVFrameDecoder.h"

#if defined(HAS_AVASSET_CONVERT_MAXVID)

@class AVAssetReader;
@class AVAssetReaderOutput;

@interface AVAssetFrameDecoder : AVFrameDecoder
{
@private
  NSURL *m_assetURL;
  AVAssetReader *m_aVAssetReader;
  AVAssetReaderOutput *m_aVAssetReaderOutput;
  
  NSTimeInterval m_frameDuration;
  NSUInteger     m_numFrames;
  int            frameIndex;
  
  CGSize detectedMovieSize;
  float prevFrameDisplayTime;
  int numTrailingNopFrames;
  
  BOOL m_isOpen;
  BOOL m_isReading;
  BOOL m_readingFinished;
  BOOL m_produceCoreVideoPixelBuffers;
}

@property (nonatomic, readonly) NSUInteger  numFrames;

// If this flag is set to TRUE (the default is FALSE) then each AVFrame produced
// by this frame decoder will contain a CVPixelBufferRef instead of an
// image. This optimized path avoids multiple pointless framebuffer copies.
// Because video data can be very very large, this optimal execution path can
// save a significant amount of execution time, but it is only valid if the rendering
// target is able to accept a CoreVideo pixel buffer directly. Currently, only a
// AVAnimatorOpenGLView is able to accept CoreVideo buffers directly.
// This value should not be changed while actually decoding frames, it should
// only be set before rendering of frames begins.

@property (nonatomic, assign) BOOL produceCoreVideoPixelBuffers;

+ (AVAssetFrameDecoder*) aVAssetFrameDecoder;

@end

#endif // HAS_AVASSET_CONVERT_MAXVID
