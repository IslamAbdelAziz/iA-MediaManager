#
# Minimum Support iOS Version = iOS 11
# Swift 5
#
# How To Use

        MediaManager.shared.addMedia(vc: self)
        MediaManager.shared.imageHandlerBlock = { (image) in
            self.imgView.image = image
        }
        
        MediaManager.shared.videoHandlerBlock = { (videoURL) in
            print("Video URL:  \(videoURL.absoluteString)")
        }
        
        MediaManager.shared.fileHandlerBlock = { (fileURL) in
            print("Video URL:  \(fileURL.absoluteString)")
        }

# You can Choose Media Options as Follows:
        MediaManager.shared.addMedia(vc: self, getPhotos: true, getVideos: false, getFiles: false, getCamera: true)


# Repo in Github 
==> https://github.com/IslamAbdelAziz/iA-MediaManager
# References
 https://medium.com/@deepakrajmurugesan/swift-access-ios-camera-photo-library-video-and-file-from-user-device-6a7fd66beca2


