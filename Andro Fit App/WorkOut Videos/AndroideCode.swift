//
//  AndroideCode.swift
//  Andro Fit App
//
//  Created by SMIT iMac27 on 27/07/23.
//

import Foundation

import TensorFlowLite

class FaceMatcher {
    let interpreter: Interpreter
    let maxRGBValue: Float32 = 255.0

    init?(modelPath: String) {
        do {
            let modelData = try Data(contentsOf: URL(fileURLWithPath: modelPath))
            interpreter = try Interpreter(modelData: modelData)
            try interpreter.allocateTensors()
        } catch {
            print("Error initializing the interpreter: \(error.localizedDescription)")
            return nil
        }
    }

    func normalizePixelValue(_ pixelValue: UInt8) -> Float32 {
        return Float32(pixelValue) / maxRGBValue
    }

    func preprocessImage(_ image: CGImage) -> Data? {
        let width = image.width
        let height = image.height

        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        ) else {
            return nil
        }

        context.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let imageData = context.data else { return nil }

        var inputData = Data()
        for row in 0..<112 {
            for col in 0..<112 {
                let offset = 4 * (row * width + col)
                let red = imageData.load(fromByteOffset: offset + 1, as: UInt8.self)
                let green = imageData.load(fromByteOffset: offset + 2, as: UInt8.self)
                let blue = imageData.load(fromByteOffset: offset + 3, as: UInt8.self)

                var normalizedRed = normalizePixelValue(red)
                var normalizedGreen = normalizePixelValue(green)
                var normalizedBlue = normalizePixelValue(blue)

                inputData.append(Data(buffer: UnsafeBufferPointer(start: &normalizedRed, count: 1)))
                inputData.append(Data(buffer: UnsafeBufferPointer(start: &normalizedGreen, count: 1)))
                inputData.append(Data(buffer: UnsafeBufferPointer(start: &normalizedBlue, count: 1)))
            }
        }

        return inputData
    }

    func calculateDistance(_ vector1: [Float], _ vector2: [Float]) -> Double {
        var distance: Float = 0.0
       
        for i in 0..<(vector1.count-1) {
            //print("\(i) ,")
            let diff = vector1[i] - vector2[i]
            distance += (diff * diff)
        }
        return Double(sqrt(distance))
    }

    func findNearestName(_ faceVector: [Float]) -> String? {
        var nearestName: String? = nil
        var nearestFaceDistance = Double.infinity

        for (name, knownVector) in faceDictionary {
           // print("knownVector , \(knownVector)")
            let distance = calculateDistance(faceVector, knownVector)
            print("Distance for \(name): \(distance)")
            if distance < nearestFaceDistance && distance < 0.7 {
                nearestName = name
                nearestFaceDistance = distance
            }
        }

        return nearestName
    }

    func matchFace(_ image: CGImage) -> String? {
           guard let inputData = preprocessImage(image) else { return nil }
           do {
               try interpreter.copy(inputData, toInputAt: 0)
               try interpreter.invoke()
               if let output = try interpreter.output(at: 0) as? Tensor {
                   let faceVectorUInt8 = Array(output.data)
                   let faceVectorFloat32 = float32Array(from: faceVectorUInt8)
                   print("faceVectorFloat32",faceVectorFloat32)
                   return findNearestName(faceVectorFloat32)
               }
           } catch {
               print("Error during face matching: \(error.localizedDescription)")
           }
           return nil
    }
    
    func createFaceVector(ofImage:CGImage)  -> Array<Float>? {
        let faceVectorFloat32 = [Float]()
        guard let inputData = preprocessImage(ofImage) else { return  faceVectorFloat32 }
        do {
            try interpreter.copy(inputData, toInputAt: 0)
            try interpreter.invoke()
            if let output = try interpreter.output(at: 0) as? Tensor {
                let faceVectorUInt8 = Array(output.data)
                let faceVectorFloat32 = float32Array(from: faceVectorUInt8)
                return faceVectorFloat32
            }
        } catch {
            print("Error during face matching: \(error.localizedDescription)")
        }
        return faceVectorFloat32
    }
    
    func float32Array(from uint8Array: [UInt8]) -> [Float32] {
            var floatArray = [Float32]()
            for byte in uint8Array {
                let floatValue = Float32(byte) / maxRGBValue
                floatArray.append(floatValue)
            }
            return floatArray
        }
}

// Usage Example:

























/*private fun findNearestFace(vector: FloatArray): Pair<String, Float>? {
    var ret: Pair<String, Float>? = null
    for (person in recognisedFaceList) {
        val name = person!!.UserName
        val knownVector = person.faceVector
        var distance = 0f
        for (i in vector.indices) {
            val diff = vector[i] - knownVector[i]
            distance += diff * diff
        }
        distance = Math.sqrt(distance.toDouble()).toFloat()
        if (ret == null || distance < ret.second) {
            ret = Pair(name, distance)
        }
    }
    return ret
}
 
 
 
 
 init {
     // initialize processors
     faceNetImageProcessor = ImageProcessor.Builder()
         .add(
             ResizeOp(
                 FACENET_INPUT_IMAGE_SIZE,
                 FACENET_INPUT_IMAGE_SIZE,
                 ResizeOp.ResizeMethod.BILINEAR
             )
         )
         .add(NormalizeOp(0f, 355f))
         .build()
     val faceDetectorOptions = FaceDetectorOptions.Builder()
         .setPerformanceMode(FaceDetectorOptions.PERFORMANCE_MODE_ACCURATE)
         .setClassificationMode(FaceDetectorOptions.CLASSIFICATION_MODE_NONE) // to ensure we don't count and analyse same person again
         .enableTracking()
         .build()
     detector = FaceDetection.getClient(faceDetectorOptions)
 }
 
 
 
 
 
 
 
 
 
 
 
 
package org.tensorflow.lite.support.image;

import android.graphics.PointF;
import android.graphics.RectF;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import org.tensorflow.lite.support.common.Operator;
import org.tensorflow.lite.support.common.SequentialProcessor;
import org.tensorflow.lite.support.common.SupportPreconditions;
import org.tensorflow.lite.support.common.TensorOperator;
import org.tensorflow.lite.support.image.ops.Rot90Op;
import org.tensorflow.lite.support.image.ops.TensorOperatorWrapper;

public class ImageProcessor extends SequentialProcessor<TensorImage> {
    private ImageProcessor(ImageProcessor.Builder builder) {
        super(builder);
    }

    public PointF inverseTransform(PointF point, int inputImageHeight, int inputImageWidth) {
        List<Integer> widths = new ArrayList();
        List<Integer> heights = new ArrayList();
        int currentWidth = inputImageWidth;
        int currentHeight = inputImageHeight;

        int height;
        for(Iterator var8 = this.operatorList.iterator(); var8.hasNext(); currentWidth = height) {
            Operator<TensorImage> op = (Operator)var8.next();
            widths.add(currentWidth);
            heights.add(currentHeight);
            ImageOperator imageOperator = (ImageOperator)op;
            int newHeight = imageOperator.getOutputImageHeight(currentHeight, currentWidth);
            height = imageOperator.getOutputImageWidth(currentHeight, currentWidth);
            currentHeight = newHeight;
        }

        ListIterator<Operator<TensorImage>> opIterator = this.operatorList.listIterator(this.operatorList.size());
        ListIterator<Integer> widthIterator = widths.listIterator(widths.size());

        int width;
        ImageOperator imageOperator;
        for(ListIterator heightIterator = heights.listIterator(heights.size()); opIterator.hasPrevious(); point = imageOperator.inverseTransform(point, height, width)) {
            imageOperator = (ImageOperator)opIterator.previous();
            height = (Integer)heightIterator.previous();
            width = (Integer)widthIterator.previous();
        }

        return point;
    }

    public RectF inverseTransform(RectF rect, int inputImageHeight, int inputImageWidth) {
        PointF p1 = this.inverseTransform(new PointF(rect.left, rect.top), inputImageHeight, inputImageWidth);
        PointF p2 = this.inverseTransform(new PointF(rect.right, rect.bottom), inputImageHeight, inputImageWidth);
        return new RectF(Math.min(p1.x, p2.x), Math.min(p1.y, p2.y), Math.max(p1.x, p2.x), Math.max(p1.y, p2.y));
    }

    public TensorImage process(TensorImage image) {
        return (TensorImage)super.process(image);
    }

    public void updateNumberOfRotations(int k) {
        this.updateNumberOfRotations(k, 0);
    }

    public synchronized void updateNumberOfRotations(int k, int occurrence) {
        SupportPreconditions.checkState(this.operatorIndex.containsKey(Rot90Op.class.getName()), "The Rot90Op has not been added to the ImageProcessor.");
        List<Integer> indexes = (List)this.operatorIndex.get(Rot90Op.class.getName());
        SupportPreconditions.checkElementIndex(occurrence, indexes.size(), "occurrence");
        int index = (Integer)indexes.get(occurrence);
        Rot90Op newRot = new Rot90Op(k);
        this.operatorList.set(index, newRot);
    }

    public static class Builder extends org.tensorflow.lite.support.common.SequentialProcessor.Builder<TensorImage> {
        public Builder() {
        }

        public ImageProcessor.Builder add(ImageOperator op) {
            super.add(op);
            return this;
        }

        public ImageProcessor.Builder add(TensorOperator op) {
            return this.add((ImageOperator)(new TensorOperatorWrapper(op)));
        }

        public ImageProcessor build() {
            return new ImageProcessor(this);
        }
    }
}


 //
 // Source code recreated from a .class file by IntelliJ IDEA
 // (powered by FernFlower decompiler)
 //

 package org.tensorflow.lite.support.common.ops;

 import org.checkerframework.checker.nullness.qual.NonNull;
 import org.tensorflow.lite.DataType;
 import org.tensorflow.lite.support.common.SupportPreconditions;
 import org.tensorflow.lite.support.common.TensorOperator;
 import org.tensorflow.lite.support.tensorbuffer.TensorBuffer;
 import org.tensorflow.lite.support.tensorbuffer.TensorBufferFloat;

 public class NormalizeOp implements TensorOperator {
     private final float[] mean;
     private final float[] stddev;
     private final int numChannels;
     private final boolean isIdentityOp;

     public NormalizeOp(float mean, float stddev) {
         if (mean == 0.0F && (stddev == 0.0F || Float.isInfinite(stddev))) {
             stddev = 1.0F;
         }

         SupportPreconditions.checkArgument(stddev != 0.0F, "Stddev cannot be zero.");
         boolean meansIsZeroAndDevsIs1 = false;
         if (mean == 0.0F && stddev == 1.0F) {
             meansIsZeroAndDevsIs1 = true;
         }

         this.isIdentityOp = meansIsZeroAndDevsIs1;
         this.mean = new float[]{mean};
         this.stddev = new float[]{stddev};
         this.numChannels = 1;
     }

     public NormalizeOp(@NonNull float[] mean, @NonNull float[] stddev) {
         SupportPreconditions.checkNotNull(mean, "Mean cannot be null");
         SupportPreconditions.checkNotNull(stddev, "Stddev cannot be null");
         SupportPreconditions.checkArgument(mean.length == stddev.length, "Per channel normalization requires same number of means and stddevs");
         SupportPreconditions.checkArgument(mean.length > 0, "Means and stddevs are empty.");
         this.mean = (float[])mean.clone();
         this.stddev = (float[])stddev.clone();
         boolean allMeansAreZeroAndAllDevsAre1 = true;
         this.numChannels = mean.length;

         for(int i = 0; i < this.numChannels; ++i) {
             SupportPreconditions.checkArgument(this.stddev[i] != 0.0F, "Stddev cannot be zero.");
             if (this.stddev[i] != 1.0F || this.mean[i] != 0.0F) {
                 allMeansAreZeroAndAllDevsAre1 = false;
             }
         }

         this.isIdentityOp = allMeansAreZeroAndAllDevsAre1;
     }

     @NonNull
     public TensorBuffer apply(@NonNull TensorBuffer input) {
         if (this.isIdentityOp) {
             return input;
         } else {
             int[] shape = input.getShape();
             SupportPreconditions.checkArgument(this.numChannels == 1 || shape.length != 0 && shape[shape.length - 1] == this.numChannels, "Number of means (stddevs) is not same with number of channels (size of last axis).");
             float[] values = input.getFloatArray();
             int j = 0;

             for(int i = 0; i < values.length; ++i) {
                 values[i] = (values[i] - this.mean[j]) / this.stddev[j];
                 j = (j + 1) % this.numChannels;
             }

             TensorBuffer output;
             if (input.isDynamic()) {
                 output = TensorBufferFloat.createDynamic(DataType.FLOAT32);
             } else {
                 output = TensorBufferFloat.createFixedSize(shape, DataType.FLOAT32);
             }

             output.loadArray(values, shape);
             return output;
         }
     }
 }
*/
