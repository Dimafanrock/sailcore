require 'rails_helper'

RSpec.describe ImageUploader do
  let(:uploader) { described_class.new }

  describe '#aws_bucket' do
    context 'when environment variable is set' do
      before { allow(ENV).to receive(:fetch).with('SAILCORE_S3_IMAGE_BUCKET', nil).and_return('test-bucket') }

      it 'returns the bucket name from ENV' do
        expect(uploader.aws_bucket).to eq('test-bucket')
      end
    end

    context 'when environment variable is missing' do
      before { allow(ENV).to receive(:fetch).with('SAILCORE_S3_IMAGE_BUCKET', nil).and_return(nil) }

      it 'returns nil' do
        expect(uploader.aws_bucket).to be_nil
      end
    end
  end
end
