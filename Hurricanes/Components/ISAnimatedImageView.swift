//
//  ISAnimatedImageView.swift
//  Hurricanes
//

import SwiftUI

/// Returns a `UIView` based on `ISAnimatedImageView` with animated image data as `PFAnimatedImage`.
///
/// - Warning: Do not use this method as it is private. Consider a public alternative.
///
/// Both view and class originate from private framework `PhotosPlayer`.
///
/// - Parameters:
///   - data: The animated image data to use.
///
/// - Returns: An infinitely looping animated image as a `UIView`.
struct ISAnimatedImageView: UIViewRepresentable {
    let data: Data
    
    func makeUIView(context: Context) -> UIView {
        let path = "/System/Library/PrivateFrameworks/PhotosPlayer.framework/PhotosPlayer"
        dlopen(path, RTLD_NOW)
        
        let animClass = NSClassFromString("PFAnimatedImage") as! NSObject.Type
        let animInstance = animClass.perform(NSSelectorFromString("alloc"))!.takeUnretainedValue()
        _ = animInstance.perform(NSSelectorFromString("initWithData:"), with: data)
        
        let controller = NSClassFromString("ISAnimatedImageView") as! UIView.Type
        let controllerInstance = controller.perform(NSSelectorFromString("alloc"))!.takeUnretainedValue()
        let instance = controllerInstance.perform(NSSelectorFromString("initWithAnimatedImage:"), with: animInstance).takeUnretainedValue() as! UIView
        
        instance.setValue(true, forKey: "playing")
        
        return instance
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

/// - Warning: Do not use this method for loading animated images as it is private. Consider a public alternative.
struct ISAnimatedImageViewLoader: View {
    var imageLoader = AnimatedImageLoader()
    let link: String
    
    var body: some View {
        Group {
            if let data = imageLoader.data {
                ISAnimatedImageView(data: data)
            } else if imageLoader.failed {
                ContentUnavailableView("Failed to load", systemImage: "exclamationmark.triangle.fill")
            } else {
                ProgressView("Loading…")
                    .frame(width: 150)
                    .onAppear {
                        imageLoader.load(from: link)
                    }
            }
        }
    }
}

@Observable class AnimatedImageLoader {
    var data: Data? = nil
    var isLoading = false
    var failed = false
    
    private var task: Task<Void, Never>? = nil
    
    func load(from link: String) {
        guard data == nil, !isLoading else { return }
        
        isLoading = true
        failed = false
        
        task = Task {
            do {
                guard let url = URL(string: link) else { return }
                print("Loading GIF:", link)
                let (fetchedData, _) = try await URLSession.shared.data(from: url)
                
                if !Task.isCancelled {
                    await MainActor.run {
                        self.data = fetchedData
                    }
                }
            } catch let error {
                if !Task.isCancelled {
                    print("GIF failure: \(error)")
                    await MainActor.run {
                        self.failed = true
                    }
                }
            }
            
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}
