/* Copyright (c) 2008 Google Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

//
//  GDataEntryYouTubePlaylist.m
//

#import "GDataEntryYouTubePlaylist.h"
#import "GDataEntryYouTubeVideo.h"

@implementation GDataEntryYouTubePlaylist

+ (GDataEntryYouTubePlaylist *)playlistEntry {
  
  GDataEntryYouTubePlaylist *entry = [[[self alloc] init] autorelease];

  [entry setNamespaces:[GDataEntryYouTubeVideo youTubeNamespaces]];
  
  return entry;
}

#pragma mark -

+ (void)load {
  [GDataObject registerEntryClass:[self class]
            forCategoryWithScheme:nil 
                             term:kGDataCategoryYouTubePlaylist];
}

- (void)addExtensionDeclarations {
  
  [super addExtensionDeclarations];
  
  Class entryClass = [self class];
  
  [self addExtensionDeclarationForParentClass:entryClass
                                   childClass:[GDataYouTubePosition class]];

  // elements for GData v1 only
  [self addExtensionDeclarationForParentClass:entryClass
                                   childClass:[GDataYouTubeDescription class]];
}

- (NSMutableArray *)itemsForDescription {
  
  NSMutableArray *items = [super itemsForDescription];

  [self addToArray:items objectDescriptionIfNonNil:[self position] withName:@"position"]; 
  
  // elements for GData v1 only
  [self addToArray:items objectDescriptionIfNonNil:[self youTubeDescription] withName:@"description"]; 
    
  return items;
}

+ (NSString *)videoEntryCategoryTerm {
  // declare the term for the category that each entry gets in the superclass's
  // init method
  return kGDataCategoryYouTubePlaylist;
}

#pragma mark -

- (GDataYouTubePosition *)position {
  return [self objectForExtensionClass:[GDataYouTubePosition class]];
}

- (void)setPosition:(GDataYouTubePosition *)obj {
  [self setObject:obj forExtensionClass:[GDataYouTubePosition class]];
}

// elements for GData v1 only
- (GDataYouTubeDescription *)youTubeDescription {
#if DEBUG
  NSAssert([self isServiceVersion1], @"deprecated");
#endif
  return [self objectForExtensionClass:[GDataYouTubeDescription class]];
}

- (void)setYouTubeDescription:(GDataYouTubeDescription *)obj {
#if DEBUG
  NSAssert([self isServiceVersion1], @"deprecated");
#endif
  [self setObject:obj forExtensionClass:[GDataYouTubeDescription class]];
}

@end