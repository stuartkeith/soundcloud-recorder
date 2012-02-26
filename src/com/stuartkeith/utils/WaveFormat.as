package com.stuartkeith.utils
{
	import com.stuartkeith.soundcloud.recorder.model.SampleBufferModel;
	import com.stuartkeith.soundcloud.recorder.vo.SampleVO;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class WaveFormat
	{
		// The format constant for 32 bit floats.
		protected static const WAVE_FORMAT_IEEE_FLOAT:int = 3;
		
		// RIFF header.
		protected static const CHUNK_ID:String = "RIFF";
		protected static const FORMAT:String = "WAVE";
		
		// fmt subchunk.
		protected static const SUBCHUNK_1_ID:String = "fmt ";
		
		// data subchunk.
		protected static const SUBCHUNK_2_ID:String = "data";
		
		// writeWaveFormat: writes a 32 bit float WAVE file from a sampleBufferModel.
		public static function writeWaveFormat(numberOfChannels:int, sampleRate:int,
				sampleBufferModel:SampleBufferModel):ByteArray
		{
			var audioFormat:int = WAVE_FORMAT_IEEE_FLOAT;
			// 1 float = 4 bytes = 32 bits.
			var bitsPerSample:int = 32;
			
			// 1 sample = 4 bytes.
			var sampleBufferLengthBytes:int = sampleBufferModel.totalSamples * 4;
			
			var bytesPerSample:int = bitsPerSample / 8;
			var byteRate:int = sampleRate * numberOfChannels * bytesPerSample;
			var blockAlign:int = numberOfChannels * bytesPerSample;
			// WAVE_FORMAT_IEEE_FLOAT requires an extra two bytes.
			var subChunk1Size:int = 16 + (audioFormat == WAVE_FORMAT_IEEE_FLOAT ? 2 : 0);
			var subChunk2Size:int = (sampleBufferLengthBytes / numberOfChannels / bytesPerSample) * numberOfChannels * bytesPerSample;
			
			var waveFile:ByteArray = new ByteArray();
			
			// WAVE files are little endian.
			waveFile.endian = Endian.LITTLE_ENDIAN;
			
			// write RIFF header.
			waveFile.writeUTFBytes(CHUNK_ID);
			waveFile.writeInt(4 + (8 + subChunk1Size) + (8 + subChunk2Size));
			waveFile.writeUTFBytes(FORMAT);
			
			// write fmt subchunk.
			waveFile.writeUTFBytes(SUBCHUNK_1_ID);
			waveFile.writeInt(subChunk1Size);
			waveFile.writeShort(audioFormat);
			waveFile.writeShort(numberOfChannels);
			waveFile.writeInt(sampleRate);
			waveFile.writeInt(byteRate);
			waveFile.writeShort(blockAlign);
			waveFile.writeShort(bitsPerSample);
			
			// write the extra two bytes that WAVE_FORMAT_IEEE_FLOAT requires.
			if (audioFormat == WAVE_FORMAT_IEEE_FLOAT)
				waveFile.writeShort(0);
			
			// write data subchunk.
			waveFile.writeUTFBytes(SUBCHUNK_2_ID);
			waveFile.writeInt(subChunk2Size);
			
			var currentSampleVO:SampleVO = sampleBufferModel.sampleVOHead;
			
			// write all samples into byteArray.
			while (currentSampleVO)
			{
				waveFile.writeFloat(currentSampleVO.sample);
				
				currentSampleVO = currentSampleVO.nextSampleVO;
			}
			
			// if subChunk2Size is odd, we need a padding byte to make it even.
			if (subChunk2Size % 2)
				waveFile.writeByte(0);
			
			// reset position of byteArray.
			waveFile.position = 0;
			
			return waveFile;
		}
	}
}
